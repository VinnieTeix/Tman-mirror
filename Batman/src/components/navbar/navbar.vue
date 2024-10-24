<template>
  <nav class="top">
    <img :src="logo" alt="Logo" />
    <div>
      <router-link v-if="userIsValid === 'employee'" to="/">Home</router-link>
      <router-link v-if="userIsValid === 'admin'" to="/admin">Admin</router-link>
      <router-link v-if="userIsValid" v-on:click="logout" to="/login">Logout</router-link>
      <router-link v-if="!userIsValid" to="/login">Login</router-link>
      <router-link v-if="!userIsValid" to="/register">Register</router-link>
    </div>
  </nav>
</template>

<script>
import { onMounted, ref, watch } from "vue";
import logo from "../../assets/images/GotimeManager.png";
import { useUserStore } from "../../stores/usersStore";

export default {
  name: "NavBar",
  data() {
    return {
      logo: logo,
    };
  },
  setup() {
    let user = ref(null);
    const userStore = useUserStore();
    let userIsValid = ref(false);

    onMounted(() => {
      user.value = userStore.user;
      userIsValid.value = checkUserIsValid();
    });

    watch(
      () => [userStore.user],
      (newUser) => {
        user.value = newUser;
        userIsValid.value = checkUserIsValid();
      }
    );

    function logout() {
      userStore.logout();
    }

    function checkUserIsValid() {
      if (Object.keys(userStore.user).length !== 0) {
        switch (userStore.user.role) {
          case "employee":
            return "employee";
          case "admin":
            return "admin";
          default:
            return null;
        }
      }
    }

    return { user, logout, userIsValid, checkUserIsValid };
  },
};
</script>

<style>
nav.top {
  position: sticky;
  top: 0px;
  z-index: 50;
  width: 100vw;
  background-color: white;
  box-shadow: rgba(99, 99, 99, 0.15) 0px 2px 8px 0px;
  padding: 10px 50px;
  height: fit-content;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
}

nav.top>img {
  filter: invert(13%) sepia(18%) saturate(0%) hue-rotate(149deg) brightness(14%) contrast(83%);
  height: 40px;
}

nav.top>div {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  gap: 20px;
}

nav.top a {
  border-bottom: solid 0px black;
  transition: 0.3s;
}

nav.top a:hover {
  border-bottom: solid 2px black;
  transition: 0.3s;
}

@media screen and (max-width: 450px) {
  nav.top>div {
    display: none;
  }

  nav.top {
    height: 100px;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }

  nav.top img {
    position: relative;
    top: 20px;
  }
}
</style>
