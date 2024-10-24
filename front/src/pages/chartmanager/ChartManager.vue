<template>
  <div>
    <the-navigation />
    <div class="chart">
      <div class="top">
        <div class="bar">
          <bar-chart :bar-data="bar" />
        </div>
        <div class="pie">
          <pie-chart :pie-data="pie" />
        </div>
      </div>
      <div class="bottom">
        <div class="line">
          <line-chart :line-data="line" />
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import TheNavigation from '../../components/nav/TheNavigation.vue'
import BarChart from '../../components/charts/bar/BarChart.vue'
import PieChart from '../../components/charts/pie/PieChart.vue'
import LineChart from '../../components/charts/line/LineChart.vue'

export default {
  name: 'main',
  components: {
    'the-navigation': TheNavigation,
    'bar-chart': BarChart,
    'pie-chart': PieChart,
    'line-chart': LineChart,
  },
  data() {
    return {
      pie: {
        labels: ['VueJs', 'EmberJs', 'ReactJs', 'AngularJs'],
        datasets: [
          {
            backgroundColor: ['#41B883', '#E46651', '#00D8FF', '#DD1B16'],
            data: [40, 20, 80, 10],
          },
        ],
      },
      line: {
        labels: [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday',
        ],
        datasets: [
          {
            label: 'Data One',
            backgroundColor: '#f87979',
            data: [8, 7, 7, 6, 8, 0, 0],
          },
        ],
      },
      bar: {
        labels: [
          'January',
          'February',
          'March',
          'April',
          'May',
          'June',
          'July',
          'August',
          'September',
          'October',
        ],
        datasets: [
          {
            backgroundColor: ['#c82834', '#244771'],
            data: [7.3, 7.3, 6.2, 6.9, 6.6, 7.4, 7.5, 8.0, 8.4, 8.92],
          },
        ],
      },
    }
  },
}
</script>
<style scoped>
.chart {
  display: flex;
  flex-direction: column-reverse;
  background: #fff;
  height: 100%;
}

.top {
  display: flex;
  flex: 1;
}

.bar {
  flex: 1;
  display: flex;
  align-items: center;
}

.pie,
.line {
  flex: 1;
}

.pie,
.line,
.bar {
  padding: 20px;
  border: #000 solid 1px;
}

.bottom {
  display: flex;
  flex: 1;
}

@media screen and (max-width: 600px) {
  .top {
    flex-direction: column;
  }
  .bar,
  .pie {
    margin-bottom: 20px;
  }
  .bar,
  .pie,
  .line {
    width: 100%;
    height: 100%;
  }
}
</style>
