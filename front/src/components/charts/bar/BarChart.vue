<template>
<Chart
    :size="{ width: 200, height: 100 }"
    :data="barData"
    :margin="margin"
    :direction="direction"
    :axis="axis">
   <Layers />
   <Widgets />
  </Chart>
</template>

  <script>
import { Chart, Grid, Line } from 'vue3-charts'
import Layers from './layers.vue';
import Widgets from './widgets.vue';

export default {
  props: {
    barData: {
        type: Object,
        required: true
    }
  },
  components: {
    Chart,
    Grid,
    Layers,
    Widgets,
    Line
  },
  data() {
    return {
        direction: 'horizontal',
        margin: {
            left: 0,
            top: 20,
            right: 20,
            bottom: 0
        },
        axis: {
          primary: {
            type: 'band'
          },
          secondary: {
            domain: ['dataMin', 'dataMax + 100'],
            type: 'linear',
            ticks: 8
          }
        }
    }
  }
}
</script> 