import { AUTH_ENDPOINTS, USER_ENDPOINTS } from '@/router/apiEndpoints'
import { axiosInstance } from '@/router/axiosInstance'
import type { LoginBody, User, UserBody } from './typesServices'

async function getUserById(id: string): Promise<{ data: { user: User } }> {
  return axiosInstance.get(USER_ENDPOINTS.GET_USER_BY_ID(id))
}

async function getUserByUsernameAndEmail(
  username: string,
  email: string,
): Promise<{ data: { user: User } }> {
  return axiosInstance.get(USER_ENDPOINTS.GET_USER_BY_USERNAME_AND_EMAIL, {
    params: { username, email },
  })
}

async function login(body: LoginBody): Promise<any> {
  return axiosInstance.post(AUTH_ENDPOINTS.LOGIN, body)
}

async function createUser(body: UserBody): Promise<any> {
  return axiosInstance.post(AUTH_ENDPOINTS.CREATE_USER, body)
}

async function updateUser(id: string, body: UserBody): Promise<any> {
  return axiosInstance.put(USER_ENDPOINTS.UPDATE_USER(id), body)
}

async function deleteUser(id: string): Promise<any> {
  return axiosInstance.delete(USER_ENDPOINTS.DELETE_USER(id))
}

export {
  createUser,
  deleteUser,
  getUserById,
  getUserByUsernameAndEmail,
  login,
  updateUser,
}
