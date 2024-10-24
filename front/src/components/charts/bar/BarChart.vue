<template>
  <Bar
    id="my-chart-id"
    :options="chartOptions"
    :data="chartData"
    :style="mystyle"
  />
</template>

<script>
import { Bar } from 'vue-chartjs'
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale,
  Colors,
} from 'chart.js'
ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

export default {
  name: 'BarChart',
  props: {
    barData: {
      type: Object,
      required: true,
    },
    title: {
      type: String,
      required: false,
      default: 'hours in the month',
    },
  },
  components: {
    Bar,
  },
  computed: {
    mystyle() {
      return {
        width: '100%',
        height: '145%',
      }
    },
  },
  data() {
    return {
      chartData: this.barData,
      chartOptions: {
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
