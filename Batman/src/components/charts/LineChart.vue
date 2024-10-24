<template>
  <div id="lineChart">
    <Line :data="chartData" :options="chartOptions" />
  </div>
</template>

<script>
import {
  CategoryScale,
  Chart as ChartJS,
  Legend,
  LineElement,
  LinearScale,
  PointElement,
  Title,
  Tooltip,
} from "chart.js";
import { Line } from "vue-chartjs";

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
);

export default {
  name: "LineChart",
  components: {
    Line,
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
        labels: this.data?.map((data) => this.formatDate(data.date)),
        datasets: [
          {
            label: "Line Chart",
            data: this.data?.map((data) => data.time),

            fill: false,
            backgroundColor: "rgba(75, 192, 192, 0.2)",
            borderColor: "rgba(75, 192, 192, 1)",
            borderWidth: 1,
          },
        ],
      }
    }
  },

  methods: {
    formatDate(date) {
      return date.toISOString().split("T")[0]
    }
  },

  data() {
    return {
      chartOptions: {
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
            beginAtZero: true,
            ticks: {
              color: "#b6baca",
            },
            x: {
              ticks: {
                color: "#b6baca",
              },
            },
          },
        },
      },
    }
  }
}
</script>

<style>
#lineChart {
  width: calc(50% - 10px);
  min-width: 270px;
  height: 300px;
}
</style>
