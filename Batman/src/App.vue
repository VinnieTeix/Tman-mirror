<template>
  <NavBar />
  <router-view />
  <MobileNavBar />
</template>

<script lang="ts">
import { defineComponent, onMounted } from "vue";
import Cookies from "js-cookie";
import MobileNavBar from "./components/navbar/mobileNavbar.vue";
import NavBar from "./components/navbar/navbar.vue";
import { useUserStore } from "./stores/usersStore";

export default defineComponent({
  components: {
    NavBar,
    MobileNavBar,
  },
  setup() {
    const userStore = useUserStore();

    onMounted(async () => {
      if (!Cookies.get("token")) return;
      userStore.setToken();
      await userStore.decodeToken();
    });
  },
});
</script>

<style>
div#app {
  display: flex;
  min-height: 100vh;
  flex-direction: column;
  align-items: start;
  width: 100vw;
}
</style>
