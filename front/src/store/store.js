import { defineStore } from 'pinia'
import axios from 'axios'

export const useGlobalStore = defineStore('global', {
  state: () => ({
    userID: '',
    email: '',
    username: '',
    granted: false,
    userLoggedIn: JSON.parse(localStorage.getItem('userLoggedIn')) || false,
    role: '',
  }),
  actions: {
    setUserLoggedIn(status) {
      this.userLoggedIn = status
      localStorage.setItem('userLoggedIn', JSON.stringify(status))
    },
    initAuth() {
      const storedStatus = JSON.parse(localStorage.getItem('userLoggedIn'))
      if (storedStatus !== null) {
        this.userLoggedIn = storedStatus
      }
    },
    setUserID(newUserID) {
      this.userID = newUserID
    },
    async getUserID() {
      const response = await this.uesrID.get('get-dates')
      console.log(response.data)
    },
    async register(values) {
      try {
        const response = await axios.post('http://localhost:4000/api/users', {
          user: {
            username: values.email.split('@')[0], // Ensure username is passed
            email: values.email,
            password: values.password,
            role: values.role, // Convert role to lowercase
          },
        })

        const userData = response.data.data
        this.userID = userData.id
        this.username = values.email.split('@')[0]
        this.setUserLoggedIn(true)
        this.email = values.email
        this.role = values.role
        this.role == 'manager' || this.role == 'admin'
          ? (this.granted = true)
          : (this.granted = false)
        this.initAuth()
        localStorage.setItem('userLoggedIn', JSON.stringify(true))
      } catch (err) {
        console.log(err)
      }
    },
    async authenticate(values) {
      localStorage.setItem('userLoggedIn', JSON.stringify(true))
      this.userID = values.id
      this.username = values.username
      this.email = values.email
      this.role = values.role
      this.role == 'manager' || this.role == 'admin'
        ? (this.granted = true)
        : (this.granted = false)
      console.log(values)
    },
    logout() {
      localStorage.removeItem('userLoggedIn') // Remove userLoggedIn from localStorage
      this.setUserLoggedIn(false) // Set userLoggedIn to false
    },
  },
})
