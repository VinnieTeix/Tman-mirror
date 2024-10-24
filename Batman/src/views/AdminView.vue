<template>
  <Admin />
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import Admin from "../components/admin/admin.vue";

export default defineComponent({
  setup() {
    return {
      Admin,
    };
  },
});
</script>

<style scoped></style>
