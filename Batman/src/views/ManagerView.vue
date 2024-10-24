<template>
  <Manager />
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import Manager from '../components/admin/manager.vue';

export default defineComponent({
  name: 'AdminView',
  setup() {
    return {
      Manager,
    };
  },
});
</script>

<style scoped></style>
