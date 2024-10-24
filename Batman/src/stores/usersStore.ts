import Cookies from 'js-cookie'
import { jwtDecode } from 'jwt-decode'
import { defineStore } from 'pinia'

import { axiosInstance } from '@/router/axiosInstance'
import type { UserBody } from '@/services/typesServices'
import {
  createUser,
  getUserById,
  getUserByUsernameAndEmail,
  login,
} from '@/services/userService'
import type { LoginResponse, User, UserActions, UserState } from './storesTypes'

export const useUserStore = defineStore<'users', UserState, {}, UserActions>({
  id: 'users',
  state: (): UserState => ({
    user: {},
  }),

  getters: {
    getUser: (state): Partial<User> => {
      return state.user
    },
    getUserId: (state): string | undefined => {
      return state.user.id
    },
    getUserUsername: (state): string | undefined => {
      return state.user.username
    },
    getUserEmail: (state): string | undefined => {
      return state.user.email
    },
    clearUser: state => {
      state.user = {}
    },
  },

  actions: {
    setToken() {
      const token = Cookies.get('token')
      axiosInstance.defaults.headers.common = {
        Authorization: `bearer ${token}`,
      }
    },

    async decodeToken(this: {
      getUserById: (id: string) => Promise<Partial<User>>
    }) {
      const token = Cookies.get('token')
      if (!token) throw new Error('Token not found')

      const decodedToken = jwtDecode<{ id: string }>(token)
      await this.getUserById(decodedToken.id)
    },

    logout() {
      this.user = {}
      Cookies.remove('user')
      Cookies.remove('token')
      axiosInstance.defaults.headers.common = { Authorization: '' }
    },

    async login(body: { username: string; password: string }) {
      const response = (await login(body)) as LoginResponse
      this.user = response.data.user
      Cookies.set('user', JSON.stringify(this.user))
      Cookies.set('token', response.data.token)
      axiosInstance.defaults.headers.common = {
        Authorization: `bearer ${response.data.token}`,
      }
    },

    async getUserById(id: string): Promise<Partial<User>> {
      const response = await getUserById(id)
      this.user = response.data.user
      return response.data.user
    },

    async getUserByUsernameAndEmail(
      username: string,
      email: string,
    ): Promise<Partial<User>> {
      const response = await getUserByUsernameAndEmail(username, email)
      this.user = response.data.user
      return response.data.user
    },

    async createUser(userData: UserBody): Promise<Partial<User>> {
      const response = await createUser(userData)
      this.user = response.data.data
      return response.data.data
    },
  },
})
