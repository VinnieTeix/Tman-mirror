<template>
  <div>
    <the-navigation />
    <div class="container">
      <h1>Clocks Page</h1>
      <base-card>
        <div class="column">
          <div class="line">
            <line-chart :line-data="pie" />
          </div>
          <Button v-if="flag" @click="toggleFlag">Clock In</Button>
          <Button v-else @click="toggleFlag">Clock Out</Button>
        </div>
      </base-card>
    </div>
  </div>
</template>
<script>
import TheNavigation from '../../components/nav/TheNavigation.vue'
import LineChart from '../../components/charts/line/LineChart.vue'
import Button from '../../components/ui/Button.vue'
import BaseCard from '../../components/ui/BaseCard.vue'
export default {
  components: {
    TheNavigation,
    LineChart,
    Button,
    BaseCard,
  },
  data() {
    return {
      flag: true,
      pie: {
        labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
        datasets: [
          {
            label: 'Data One',
            backgroundColor: '#f87979',
            data: [8, 7, 7, 6, 8, 0, 0],
          },
        ],
      },
    }
  },
  methods: {
    toggleFlag() {
      this.flag = !this.flag
    },
  },
}
</script>
<style scoped>
h1 {
  display: flex;
  align-self: center;
}
.container {
  display: flex;
  flex-direction: column;
}
.column {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 20px;
}
.card {
  width: 140%;
}
.chart {
  background: #fff;
  color: #000;
  border-radius: 4%;
}
.line {
  background-color: #fff;
  color: #000;
  border-radius: 5px;
  width: 40%;
  height: 60%;
  margin-bottom: 5%;
}

@media screen and (max-width: 600px) {
  .column {
    width: 100%;
    display: flex;
    align-items: center;
  }
  .card {
    width: 100%;
  }
}
</style>
