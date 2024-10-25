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
            <div class="input-group">
              <select v-model="role">
                <option :value="null" selected disabled>Your role</option>
                <option value="user">User</option>
                <option value="manager">Manager</option>
                <option value="admin">Admin</option>
              </select>
            </div>
                  <button type="submit" class="signButton" @click="postUser"> Register </button>
          </form>
        </base-card>
    </div>
</template>
<script>

import axios from 'axios';
import {useGlobalStore} from "@/store/store.js";

export default {
  name: 'register',
    data() {
        return {
          username: '',
          email: '',
          password: '',
          role: null,
      }
    },
    methods: {
        async postUser() {
          const store = useGlobalStore();
          try {
            const response = await axios.post("http://localhost:4000/api/users", {
              user: {
                username: this.email.split('@')[0], // Ensure username is passed
                email: this.email,
                password: this.password,
                role: this.role.toLowerCase(), // Convert role to lowercase
              },
            });

            // Assuming the user object is in the response
            const userID = response.data.user.id;
            store.setUserID(userID);

            // Redirect to the chart manager page
            this.$router.push("/chartmanager");
          } catch (error) {
            console.error("Error creating user:", error.response.data);
          }

        }
    },
    }
</script>
<style scoped>
option:disabled {
  color: #9ca3af;
}

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

select {
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
