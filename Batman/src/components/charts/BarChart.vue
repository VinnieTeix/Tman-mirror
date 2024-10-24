<template>
  <div id="barChart">
    <Bar :data="chartData" :options="chartOptions" />
  </div>
</template>

<script>
import {
  BarElement,
  CategoryScale,
  Chart as ChartJS,
  Legend,
  LinearScale,
  Title,
  Tooltip,
} from "chart.js";
import { Bar } from "vue-chartjs";

ChartJS.register(
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale
);

export default {
  name: "Bar Chart",
  components: {
    Bar,
  },
  props: {
    data: {
      type: Array,
      required: true,
    },
  },
  computed: {
    chartData() {
      return {
        labels: this.data?.map((data) => data.time),
        datasets: [
          {
            label: "Bar Chart",
            data: this.data?.map((data) => data.occurences),
            backgroundColor: "rgba(75, 192, 192, 0.2)",
            borderColor: "rgba(75, 192, 192, 1)",
            borderWidth: 1,
          },
        ],
      };
    },
    chartOptions() {
      return {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          title: {
            display: true,
            text: "Number of occurrences of the hours worked",
          },
        },
        scales: {
          y: {
            beginAtZero: true,
            ticks: {
              color: "#b6baca",
            },
          },
          x: {
            ticks: {
              color: "#b6baca",
            },
          },
        },
      };
    },
  },
};
</script>

<style>
#barChart {
  width: calc(50% - 10px);
  /* 50% - 60px (margin) - 10px (gap) */
  min-width: 270px;
  height: 300px;
}
</style>
