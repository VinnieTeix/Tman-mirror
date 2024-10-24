<template>
  <div>
    <canvas id="doughnutChart" width="47" height="68"></canvas>
  </div>
</template>

<script>
import Chart from 'chart.js/auto';

export default {
  name: 'doughnutChart',
  mounted() {
    this.createDoughnutChart();
  },
  methods: {
    createDoughnutChart() {
      const data = {
        labels: ['Red', 'Blue', 'Yellow'],
        datasets: [
          {
            label: 'My First Dataset',
            data: [300, 50, 100],
            backgroundColor: [
              'rgb(255, 99, 132)',
              'rgb(54, 162, 235)',
              'rgb(255, 205, 86)'
            ],
            hoverOffset: 4
          }
        ]
      };

      const config = {
        type: 'doughnut',
        data: data,
        options: {
          scales: {
            y: {
              beginAtZero: true
            }
          }
        }
      };

      const ctx = document.getElementById('doughnutChart').getContext('2d');
      new Chart(ctx, config);
    },
  },
};
</script>
<style>
#doughnutChart {
  width: calc(50% - 10px);
  /* 50% - 60px (margin) - 10px (gap) */
  min-width: 270px;
  height: 120px;
}
</style>
