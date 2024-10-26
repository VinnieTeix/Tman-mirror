import { defineStore } from 'pinia'
import axios from 'axios'

export const useGlobalStore = defineStore('global', {
  state: () => ({
    userID: '',
    email: '',
    username: '',
    userLoggedIn: false,
    role: '',
  }),
  actions: {
    setUserID(newUserID) {
      this.userID = newUserID
    },
    async getUserID() {
      const response = await this.uesrID.get('get-dates')
      console.log(response.data)
    },
    async register(values) {
      await axios
        .post('http://localhost:4000/api/users', {
          user: {
            username: values.email.split('@')[0], // Ensure username is passed
            email: values.email,
            password: values.password,
            role: values.role, // Convert role to lowercase
          },
        })
        .then(res => (this.userID = res.data.data.id))
      this.userLoggedIn = true
      this.username = values.email.split('@')[0]
      this.email = values.email
      this.role = values.role
    },
    async authenticate(values) {
      console.log(values)
      this.userID = values.id
      this.userLoggedIn = true
      this.username = values.username
      this.email = values.email
      this.role = values.role
    },
    logout() {
      this.userLoggedIn = false
    },
  },
})
