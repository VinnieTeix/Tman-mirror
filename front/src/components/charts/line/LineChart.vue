<template>
  <Line :data="chartData" :options="chartOptions" :style="mystyle" />
</template>
<script>
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
} from 'chart.js'
import { Line } from 'vue-chartjs'
ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
)

export default {
  props: {
    lineData: {
      type: Object,
      required: true,
    },
    title: {
      type: String,
      required: false,
      default: 'Hours in the week',
    },
  },
  computed: {
    mystyle() {
      return {
        width: '100%',
        height: '120%',
      }
    },
  },
  components: {
    Line,
  },
  data() {
    return {
      chartData: this.lineData,
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
