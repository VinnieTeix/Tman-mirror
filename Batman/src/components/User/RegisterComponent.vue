<template>
  <div class="w-full max-w-lg p-3 relative mx-auto my-auto rounded-xl shadow-lg bg-white my-8">
    <form class="bg-white rounded p-8" @submit.prevent="createUser">
      <h1 class="text-xl pb-3">Register</h1>

      <div class="email-input mb-6">
        <label for="email" class="block text-gray-700 text-sm font-bold mb-2">Email</label>
        <input aria-describedby="emailHelp" v-model="email"
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline"
          id="email" type="email" placeholder="your@email.com" />
        <span class="text-xs text-red-700" id="emailHelp"></span>
      </div>

      <div class="username-input mb-4">
        <label for="username" class="block text-gray-700 text-sm font-bold mb-2">Username</label>
        <input id="username"
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline"
          type="text" placeholder="username" aria-describedby="usernameHelp" v-model="username" />
        <span class="text-xs text-red-700" id="usernameHelp"></span>
      </div>

      <div class="password-input mb-4">
        <label for="password" class="block text-gray-700 text-sm font-bold mb-2">Password</label>
        <input id="password"
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline"
          type="password" placeholder="Password" aria-describedby="passwordHelp" v-model="password" />
        <span class="text-xs text-red-700" id="passwordHelp"></span>
      </div>

      <div class="flex items-center justify-between">
        <button
          class="bg-blue-600 hover:bg-black text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
          type="submit">
          Register
        </button>
      </div>
    </form>
  </div>
</template>

<script lang="ts">
import type { UserBody } from "@/services/typesServices";
import { defineComponent } from "vue";
import { useUserStore } from "../../stores/usersStore";

export default defineComponent({
  name: "RegisterComponent",
  data() {
    return {
      isOpen: false,
      username: "",
      email: "",
      password: "",
    };
  },
  methods: {
    async createUser() {
      const user: UserBody = {
        username: this.username,
        email: this.email,
        password: this.password,
      };

      try {
        const userStore = useUserStore();
        const createdUser = await userStore.createUser(user);
        if (createdUser) {
          this.$router.push("/");
        } else {
          console.error("Unexpected response from the API:", createdUser);
        }
      } catch (error) {
        console.error("API request failed:", error);
      }
    },
  },
});
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
}

.fade-enter,
.fade-leave-to {
  opacity: 0;
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 500ms ease-out;
}
</style>
