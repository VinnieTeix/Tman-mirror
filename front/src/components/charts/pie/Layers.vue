<template #layers>
  <Pie
    :dataKeys="['name', 'pl']"
    :pie-style="{ innerRadius: 100, padAngle: 0.05 }"
  />
</template>
<script>
import { Pie } from 'vue3-charts'

export default {
  components: {
    Pie,
  },
}
</script>
