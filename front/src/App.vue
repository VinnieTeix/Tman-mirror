<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'app',
}
</script>

<style>
* {
  box-sizing: border-box;
}

html {
  font-family: sans-serif;
  background-color: #222;
  color: #fff;
}

body {
  margin: 0;
}

#app {
  position: relative;
  overflow: hidden;
  width: 100%;
  height: 100%;
}

css-doodle {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: -1;
}
</style>
