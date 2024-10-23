<script>
import TheNavigation from './components/nav/TheNavigation.vue';
import axios from 'axios';
export default {
  components: {
    TheNavigation
  },
  data() {
        return {
            username: '',
            email: '',
            users: []
        }
    },
    methods: {
        postUser() {
            axios.post("http://localhost:4000/api/users", {
                user: { username: this.username,
                email: this.email
                }
            }).catch(error => {
                    console.log(error)
                })
                console.log(this.username, this.email)
            this.username = ''
            this.email = ''
        },

    },
}
</script>
<template>
  <the-navigation/>
  <main>
    <router-view></router-view>
    <div>
        <form @submit.prevent="">
        <input type="text" id="username" name="username" placeholder="username" v-model.trim="username">
        <input type="text" id="email" name="email" placeholder="email" v-model.trim="email">
            <button @click="postUser">Add User</button>
        </form>
        <ul>

        </ul>
    </div>
  </main>
</template>

<style>
* {
  box-sizing: border-box;
}

html {
  font-family: sans-serif;
}

body {
  margin: 0;
}
</style>
