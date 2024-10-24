<template>
  <div>
    <WorkingTimes />
    <ClockManager />
    <ChartManager />
  </div>
</template>

<script lang="ts">
import ChartManager from "../components/charts/ChartManager.vue";
import ClockManager from "../components/ClockManager.vue";
import WorkingTimes from "../components/WorkingTime/WorkingTimes.vue";
export default {
  components: {
    ChartManager,
    WorkingTimes,
    ClockManager,
  },
};
</script>

<style scoped></style>
