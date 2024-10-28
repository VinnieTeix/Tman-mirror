<template>
  <div class="login-container">
    <h1>Login Page</h1>
    <base-card>
      <form @submit.prevent="loginUser">
        <div class="input-group">
          <input
            type="email"
            v-model="user.email"
            placeholder="email@email.com"
          />
        </div>
        <div class="input-group">
          <input
            type="password"
            v-model="user.password"
            placeholder="*********"
          />
        </div>
        <button class="signButton" type="submit">Login</button>
        <router-link class="registerButton" to="/register"
          >Register</router-link
        >
      </form>
    </base-card>
  </div>
</template>
<script>
import axios from 'axios'
import 'css-doodle'
import { mapActions } from 'pinia'
import { useGlobalStore } from '@/store/store.js'

export default {
  name: 'auth',
  data() {
    return {
      user: {
        password: '',
        email: '',
      },
    }
  },
  mounted() {
    const store = useGlobalStore()
    console.log(store.apiHost)
    axios
      .get(`http://${store.apiHost}:4000/api/users`)
      .then(response => (this.users = response.data.data))
      .catch(error => {
        console.log(error)
      })
  },

  methods: {
    ...mapActions(useGlobalStore, { auth: 'authenticate' }),

    async loginUser() {
      const user = this.users.find(
        user =>
          user.email === this.user.email &&
          user.password === this.user.password,
      )
      try {
        console.log('Authenticating user:', user)
        await this.auth(user)
        console.log('User authenticated successfully')
        this.$router.push('/clocks') // Redirect to a protected route
      } catch (error) {
        console.log('Authentication failed:', error)
        return
      }
    },
  },
}
</script>
<style scoped>
h1 {
  font-size: 2.5em;
  margin-bottom: 20px;
  text-align: center;
}
.login-container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100vh;
}

form {
  display: flex;
  flex-direction: column;
  width: 300px;
  padding: 20px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
}

h2 {
  margin-bottom: 20px;
  text-align: center;
}
.input-group {
  margin-bottom: 15px;
}

label {
  margin-right: 1em;
  margin-bottom: 5px;
  font-weight: bold;
}

input {
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  width: 100%;
}

.signButton {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 10px;
  color: white;
  font-size: 15px;
  border: none;
  cursor: pointer;
}

.registerButton:hover {
  background-color: rgb(122, 89, 206);
  color: #000;
}

.registerButton {
  display: flex;
  justify-content: center;
  align-items: center;
  text-decoration: none;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  padding: 10px;
  margin-top: 1em;
  background-color: #542ded; /* Primary color */
  color: white;
  font-size: 15px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition:
    background-color 0.3s ease,
    color 0.3s ease;
}

.signButton:hover {
  background-color: #0d71dc;
}
</style>
