<script>
import axios from 'axios'
export default {
    data() {
        return {
            users: []
        }
    },
    methods: {
        async getUsers() {
            const response = await axios.get("http://phoenix:4000/api/users")
                .then(response => response.data)
                .catch(error => {
                    console.log(error)
                })
            this.users = response.data
            console.log(this.users)
        }
    }
}
</script>
<template>
    <div>
        <h1> Users Profile </h1>
        <button @click="getUsers">Get Users</button>
        <ul>
            <li v-for="user in users" :key="user.id">
                <p> {{ user.username }} </p>
                <p> {{ user.email }} </p>
            </li>
        </ul>
    </div>
</template>
<style scoped>

</style>
