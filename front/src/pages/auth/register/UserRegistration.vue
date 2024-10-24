<template>
    <div class="login-container">
        <h1>Registration Page</h1>
        <base-card>
          <form @submit.prevent>
              <div class="input-group">
                  <input type="email" v-model="email" placeholder="email@email.com">
              </div>
              <div class="input-group">
                  <input type="password" v-model="password" placeholder="********">
              </div>
                  <button type="submit" class="signButton" @click="postUser"> Register </button>
          </form>
        </base-card>
    </div>
</template>
<script>

import axios from 'axios';

export default {
  name: 'register',
    data() {
        return {
        password: '',
        email: ''
      }
    },
    methods: {
      postUser() {
        console.log("Method called")
        axios.post("http://localhost:4000/api/users", {
            user: { username: this.email.split('@')[0] + this.email.split('@')[1].split('.')[0],
            email: this.email,
            password: this.password
            }
        })
            console.log(this.username, this.email, this.password)
            this.$router.push('/chartmanager')
        }
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
  display: grid;
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
  background-color: #007bff;
  color: white;
  font-size: 15px;
  border: none;
  border-radius: 4px;
  width: 100%;
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
  padding: 10px;
  margin-top: 1em;
  background-color: #542ded; /* Primary color */
  color: white;
  font-size: 15px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease, color 0.3s ease;
}

.signButton:hover {
  background-color: #0d71dc;
}
</style>