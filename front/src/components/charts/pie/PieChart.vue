<template>
  <Doughnut :data="chartData" :options="chartOptions" />
</template>
<script>
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from 'chart.js'
import { Doughnut } from 'vue-chartjs'

ChartJS.register(ArcElement, Tooltip, Legend)

export default {
  props: {
    pieData: {
      type: Object,
      required: true,
    },
    title: {
      type: String,
      required: false,
      default: 'Subjects',
    },
  },
  name: 'App',
  components: {
    Doughnut,
  },
  data() {
    return {
      chartData: this.pieData,
      chartOptions: {
        maintainAspectRatio: false,
        responsive: true,
        plugins: {
          title: {
            display: true,
            text: this.title,
          },
          legend: { display: false },
        },
      },
    }
  },
}
</script>

<style></style>
