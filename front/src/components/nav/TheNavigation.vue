<template>
  <header>
    <nav>
      <h4 @click="logout" class="logout">Log out</h4>
      <ul>
        <li>
          <router-link to="/user">Profile</router-link>
        </li>
        <li v-if="granted">
          <router-link to="/chartmanager">Chart Manager</router-link>
        </li>
        <li>
          <router-link to="/clocks">Clocks</router-link>
        </li>
        <li v-if="granted">
          <router-link to="/Workingtimes">WorkingTimes</router-link>
        </li>
      </ul>
    </nav>
  </header>
</template>
<script>
import { useGlobalStore } from '@/store/store.js'

export default {
  setup() {
    const store = useGlobalStore()
    return {
      granted: store.granted,
    }
  },
}
</script>
<style scoped>
header {
  width: 100%;
  height: 5rem;
  background-image: linear-gradient(#222, #222);
}

nav {
  height: 100%;
  display: flex;
}

ul {
  list-style: none;
  margin: 0;
  padding: 0;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
}

.logout {
  cursor: pointer;
  margin-left: auto;
  align-self: center;
  margin: 2rem;
}

li {
  margin: 0 2rem;
}

a {
  text-decoration: none;
  background: transparent;
  border: 1px solid transparent;
  cursor: pointer;
  color: white;
  padding: 0.5rem 1.5rem;
  display: inline-block;
}

@media screen and (max-width: 768px) {
  header {
    height: 10rem;
  }
  nav {
    display: flex;
    flex-direction: column;
    justify-content: center;
  }
  li {
    margin: 1rem 0;
    padding: 5%;
  }
  a {
    padding: 0.5rem 0;
  }
}
</style>
