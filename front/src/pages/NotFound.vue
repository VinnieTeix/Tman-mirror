<template>
    <section>
      <base-card>
        <h2>Page not found</h2>
        <p>
          This page could not be found
          <router-link to="/">Home</router-link>.
        </p>
      </base-card>
    </section>
  </template>
  <script>
  export default {
  name: 'notfound',
  data() {
    return {
  
    }
  }
}
  </script>