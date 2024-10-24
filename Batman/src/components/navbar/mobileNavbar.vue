<template>
  <nav class="mobile">
    <div>
      <router-link v-if="userIsValid" to="/">
        <i class="pi pi-home"></i> <!-- Home icon -->
      </router-link>

      <router-link v-if="userIsValid" v-on:click="logout" to="/login">
        <i class="pi pi-sign-out"></i> <!-- Logout icon -->
      </router-link>

      <router-link v-if="!userIsValid" to="/login">
        login
      </router-link>

      <router-link v-if="!userIsValid" to="/register">
        register
      </router-link>
      <!-- <router-link v-if="user.status === 'admin'" to="/register">Admin</router-link> -->
    </div>
  </nav>
</template>


<script>
import { onMounted, ref, watch } from "vue";
import { useUserStore } from "../../stores/usersStore";

export default {
  name: "MobileNavBar",
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
      return Object.keys(userStore.user).length !== 0;
    }

    return { user, logout, userIsValid, checkUserIsValid };
  },
};
</script>


<style>
nav.mobile {
  position: sticky;
  bottom: 0px;
  z-index: 50;
  width: 100vw;
  background-color: white;
  box-shadow: rgba(99, 99, 99, 0.15) 0px 2px 8px 0px;
  padding: 10px 50px;
  height: 50px;
  display: flex;
  flex-direction: row;
  justify-content: space-around;
}

nav.mobile i {
  font-size: 24px;
  filter: invert(13%) sepia(18%) saturate(0%) hue-rotate(149deg) brightness(14%) contrast(83%);
}

nav.mobile img {
  filter: invert(13%) sepia(18%) saturate(0%) hue-rotate(149deg) brightness(14%) contrast(83%);
  position: relative;
  bottom: 5px;
}

nav.mobile>div {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  gap: 20px;
}

nav.mobile a {
  border-bottom: solid 0px black;
  transition: 0.3s;
}

nav.mobile a:hover {
  border-bottom: solid 2px black;
  transition: 0.3s;
}

@media screen and (min-width: 450px) {
  nav.mobile {
    display: none;
  }
}
</style>
