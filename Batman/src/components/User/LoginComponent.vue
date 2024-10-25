<template>
  <div class="w-full max-w-lg p-3 relative mx-auto my-auto rounded-xl shadow-lg bg-white my-5">
    <form class="bg-white rounded p-8" @submit.prevent="login">
      <h1 class="text-xl pb-3">Login</h1>
      <div class="identity-input mb-4">
        <label for="identity" class="block text-gray-700 text-sm font-bold mb-2">Email</label>
        <input id="identity"
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline"
          type="text" placeholder="Enter your email" aria-describedby="usernameHelp" v-model="email" />
      </div>

      <div class="password-input mb-6">
        <label for="password" class="block text-gray-700 text-sm font-bold mb-2">Password</label>
        <input aria-describedby="emailHelp" v-model="password"
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline"
          id="password" type="password" placeholder="Enter your password" />
      </div>

      <div class="flex items-center justify-between">
        <button
          class="bg-blue-600 hover:bg-black text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
          type="submit">
          Sign In
        </button>
      </div>
    </form>
  </div>
</template>

<script>
import { useUserStore } from "../../stores/usersStore.ts";

export default {
  name: "LoginComponent",
  data() {
    return {
      isOpen: false,
      email: "",
      password: "",
      isLoggedIn: false,
    };
  },

  computed: {
    isModalVisible() {
      return this.isOpen;
    },
    checkUser() {
      const user = useUserStore().getUser;
      if (Object.keys(user).length > 0) {
        return user.role === "employee" ? "/" : "/admin";
      }
      return null;
    },
  },

  watch: {
    checkUser(newRoute) {
      if (newRoute) {
        this.$router.push(newRoute);
      }
    },
  },

  methods: {
    onToggle() {
      this.isOpen = !this.isOpen;
    },

    async login() {
      const userEmail = this.email;
      const userPassword = this.password;

      try {
        const userStore = useUserStore();
        await userStore.login({
          email: userEmail,
          password: userPassword,
        });

        if (userStore.getUser) {
          this.$router.push(this.checkUser);
        } else {
          console.error("Unexpected response from the API.");
        }
      } catch (error) {
        console.error("API request failed:", error);
      }
    },
  },
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
}
</style>
