<template>
  <div>
    <the-navigation />
    <div class="chart">
      <div class="pie">
        <pie-chart :pie-data="pie" />
      </div>
      <div class="line">
        <line-chart :line-data="line" />
      </div>
      <div class="bar">
        <bar-chart :bar-data="bar" />
      </div>
    </div>
  </div>
</template>
<script>
import { mapWritableState } from 'pinia'
import { useGlobalStore } from '@/store/store.js'
import TheNavigation from '@/components/nav/TheNavigation.vue'
import BarChart from '@/components/charts/bar/BarChart.vue'
import PieChart from '@/components/charts/pie/PieChart.vue'
import LineChart from '@/components/charts/line/LineChart.vue'

export default {
  name: 'main',
  components: {
    'the-navigation': TheNavigation,
    'bar-chart': BarChart,
    'pie-chart': PieChart,
    'line-chart': LineChart,
  },
  computed: {
    ...mapWritableState(useGlobalStore, ['userLoggedIn', 'granted']),
  },
  created() {
    if (!this.userLoggedIn) {
      this.$router.push('/auth')
    }
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
            data: [140, 160, 138, 120, 142, 141, 108, 172, 123, 153],
          },
        ],
      },
    }
  },
}
</script>
<style scoped>
.chart {
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-column: col 3 / span 2;
  grid-row: row 2;
  gap: 20px;
  flex-direction: column-reverse;
}

.bar {
  grid-column: 1 / 3;
  grid-row: 2;
}

.line {
  grid-column: 1;
  grid-row: 1;
}

.pie {
  grid-column: 2;
  grid-row: 1;
}

.pie,
.line,
.bar {
  padding: 20px;
  border: #000 solid 1px;
  background-color: #fff;
  border-radius: 25px;
}

@media screen and (max-width: 1000px) {
  .chart {
    grid-template-columns: 1fr;
  }
  .bar {
    grid-column: 1;
    grid-row: 3;
  }
  .line {
    grid-column: 1;
    grid-row: 2;
  }
  .pie {
    grid-column: 1;
    grid-row: 1;
  }
}
</style>
