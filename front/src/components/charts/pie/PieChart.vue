<template>
  <Responsive class="w-full">
    <template #main="{ width }">
      <Chart
        direction="circular"
        :size="{ width, height: 400 }"
        :data="data"
        :margin="{
          left: Math.round((width - 360) / 2),
          top: 20,
          right: 0,
          bottom: 20,
        }"
        :axis="axis"
        :config="{ controlHover: false }"
      >
        <template #layers>
          <Pie
            :dataKeys="['name', 'pl']"
            :pie-style="{ innerRadius: 100, padAngle: 0.05 }"
          />
        </template>
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
      </Chart>
    </template>
  </Responsive>
</template>

<script>
import { Chart, Responsive, Pie, Tooltip } from 'vue3-charts'
export default {
  components: {
    Chart,
    Responsive,
    Pie,
    Tooltip,
  },
  data() {
    return {
      data: [
        { name: 'Jan', pl: 1000, avg: 500, inc: 300 },
        { name: 'Feb', pl: 2000, avg: 900, inc: 400 },
        { name: 'Apr', pl: 400, avg: 400, inc: 500 },
        { name: 'Mar', pl: 3100, avg: 1300, inc: 700 },
        { name: 'May', pl: 200, avg: 100, inc: 200 },
        { name: 'Jun', pl: 600, avg: 400, inc: 300 },
        { name: 'Jul', pl: 500, avg: 90, inc: 100 },
      ],
    }
  },
}
</script>

<style></style>
