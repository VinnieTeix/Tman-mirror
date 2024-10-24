<template #widgets>
  <Tooltip
    :config="{
      name: {},
      avg: { hide: true },
      pl: { label: 'value' },
      inc: { hide: true },
    }"
    hideLine
  />
</template>
<script>
import { Tooltip } from 'vue3-charts'

export default {
  components: {
    Tooltip,
  },
}
</script>
