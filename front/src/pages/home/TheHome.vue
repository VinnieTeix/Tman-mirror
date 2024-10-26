<template>
  <div class="home-container">
    <base-card>
      <h1>Welcome to Gotham city</h1>
      <h4>Working Times</h4>
      <p>Please log in or register to continue.</p>
      <div class="auth-buttons">
        <router-link to="/login">Login</router-link>
        <router-link to="/register">Register</router-link>
      </div>
    </base-card>
  </div>
</template>
<script>
export default {
  name: 'home',
  data() {
    return {
      clockIn: false,
    }
  },
}
</script>
<style>
* {
  box-sizing: border-box;
}

html {
  font-family: sans-serif;
}

body {
  margin: 0;
  padding: 0;
}

h1,
h2,
h3,
h4,
h5,
h6 {
  text-transform: uppercase;
  letter-spacing: 0.12em;
}

h4 {
  padding: 0.25px;
}

.home-container {
  text-align: center;
}

.auth-buttons {
  display: flex;
  justify-content: space-around;
  margin-top: 20px;
}

.auth-buttons a,
button {
  color: white;
  background-color: #aaa;
  padding: 10px 20px;
  border-radius: 5px;
  transition: background-color 0.3s ease;
}

.auth-buttons a:hover,
button {
  background-color: #aaa;
}

.auth-buttons button {
  margin: 0 10px;
  padding: 10px 20px;
  font-size: 16px;
  cursor: pointer;
}

a {
  text-decoration: none;
}
</style>
