<template>
  <button>
    <slot></slot>
  </button>
</template>

<style>
button {
  display: inline-block;
  padding: 0.75rem 1.25rem;
  border-radius: 10rem;
  color: #fff;
  text-transform: uppercase;
  font-size: 2rem;
  letter-spacing: 0.15rem;
  transition: all 0.3s;
  position: relative;
  overflow: hidden;
  z-index: 1;
}
button:after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: #333;
  border-radius: 10rem;
  z-index: -2;
}
button:before {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 0%;
  height: 100%;
  background-color: #555;
  transition: all 0.3s;
  border-radius: 10rem;
  z-index: -1;
}
button:hover {
  color: #fff;
}
button:hover:before {
  width: 100%;
}
</style>
