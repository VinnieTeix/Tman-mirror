<template>
  <nav>
    <ul>
      <li><router-link to="/">Accueil</router-link></li>
      <li><router-link to="/about">À propos</router-link></li>
    </ul>
  </nav>
</template>

<script>
export default {
  name: "navBar",
};
</script>

<style scoped>
nav {
  background-color: #333;
  color: #fff;
  padding: 10px;
  width: 100%;

}

ul {
  list-style: none;
  padding: 0;
  display: flex;
}

li {
  margin-right: 20px;
}

a {
  text-decoration: none;
  color: #fff;
  font-weight: bold;
  transition: color 0.3s;
}

a:hover {
  color: #ff5722;
  /* Changez la couleur au survol selon vos préférences */
}
</style>
