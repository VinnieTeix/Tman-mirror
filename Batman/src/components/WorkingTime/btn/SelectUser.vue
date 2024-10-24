<template>
  <button class="select-button" @click="selectUser">
    Sélectionner l'utilisateur
  </button>
</template>

<script>
export default {
  name: 'selectUser',
  methods: {
    selectUser() {
    },
  },
};
</script>

<style scoped>
.select-button {
  background-color: #007bff;
  color: #fff;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.select-button:hover {
  background-color: #0056b3;
}
</style>
