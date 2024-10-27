<script>
import { useGlobalStore } from '@/store/store.js'
import TheNavigation from '@/components/nav/TheNavigation.vue'
import LineChart from '../../components/charts/line/LineChart.vue'

export default {
  // test@test.com
  components: {
    TheNavigation,
    LineChart,
  },
  setup() {
    const store = useGlobalStore()
    return {
      username: store.username,
      role: store.role,
    }
  },
  data() {
    return {
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
            backgroundColor: '#f87979',
            data: [8, 7, 7, 6, 8, 0, 0],
          },
        ],
      },
    }
  },
}
</script>
<template>
  <div>
    <the-navigation />
    <div class="container">
      <h1>Profile</h1>
      <base-card>
        <p>{{ username }}</p>
        <p>{{ role }}</p>
        <div class="line">
          <line-chart :line-data="line" />
        </div>
      </base-card>
    </div>
  </div>
</template>
<style scoped>
h1 {
  display: flex;
  align-self: center;
}
.container {
  display: flex;
  flex-direction: column;
}
.line {
  background-color: white;
  width: 100%;
  height: 20em;
  margin-top: 20px;
}
.card {
  width: 140%;
}

@media screen and (min-width: 768px) {
  .card {
    width: 100%;
  }
}
</style>
