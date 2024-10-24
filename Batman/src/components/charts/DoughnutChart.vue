<template>
  <div id="doughnutChart">
    <Doughnut :data="chartData" :options="chartOptions" />
  </div>
</template>

<script>
import { ArcElement, Chart as ChartJS, Legend, Tooltip } from "chart.js";
import { Doughnut } from "vue-chartjs";
ChartJS.register(ArcElement, Tooltip, Legend);

export default {
  name: "DoughnutChart",
  components: {
    Doughnut,
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
        labels: this.data?.map((data) => data.day),
        datasets: [
          {
            label: "DoughnutChart",
            data: this.data?.map((data) => data.time),
            backgroundColor: [
              "rgb(3, 4, 94)",
              "rgb(2, 62, 138)",
              "rgb(0, 119, 182)",
              "rgb(0, 150, 199)",
              "rgb(0, 180, 216)",
              "rgb(72, 202, 228)",
              "rgb(144, 224, 239)",
            ],
            hoverOffset: 4,
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
            text: "Sum of the number of hours worked per day of the week",
          },
        },
        scales: {
          y: {
            display: false,
          },
          x: {
            display: false,
          },
        },
      };
    },
  },
};
</script>

<style>
#doughnutChart {
  width: calc(50% - 10px);
  /* 50% - 60px (margin) - 10px (gap) */
  height: 300px;
}
</style>
