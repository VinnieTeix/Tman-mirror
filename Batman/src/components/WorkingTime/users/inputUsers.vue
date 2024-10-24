<template>
  <div class="input-container">
    <label for="username">Nom d'utilisateur</label>
    <input type="text" id="username" v-model="username" placeholder="Entrez votre nom d'utilisateur" />
    <label for="email">Email</label>
    <input type="text" id="email" pattern=".+@globex\.com" size="30" required v-model="email"
      placeholder="Entrez votre email" />
  </div>
</template>

<script>
export default {

  data() {
    return {
      username: "",
    };
  },
};
</script>

<style scoped>
.input-container {
  margin-bottom: 20px;
}

label {
  display: block;
  font-weight: bold;
}

input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  outline: none;
}

/* Ajoutez ici des styles supplémentaires selon vos besoins */
</style>
