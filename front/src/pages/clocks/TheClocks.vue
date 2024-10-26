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
          <Button v-if="flag" @click="clockOut">Clock In</Button>
          <Button v-else @click="clockIn">Clock Out</Button>
        </div>
      </base-card>
    </div>
  </div>
</template>
<script>
import TheNavigation from '../../components/nav/TheNavigation.vue'
import LineChart from '../../components/charts/line/LineChart.vue'
import Button from '../../components/ui/Button.vue'
import axios from 'axios'
import { useGlobalStore } from '@/store/store.js'

export default {
  components: {
    TheNavigation,
    LineChart,
    Button,
  },
  setup() {
    const store = useGlobalStore()
    return {
      userID: store.userID,
    }
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
    clockIn() {
      axios.post('http://localhost:4000/api/clocks/:userID', {
        clock: {
          status: true,
          time: new Date(),
          user: this.userID,
        },
      })
      console.log(this.userID)
      this.flag = !this.flag
    },
    clockOut() {
      axios.post('http://localhost:4000/api/clocks/:userID', {
        clock: {
          status: false,
          time: new Date(),
          user: this.userID,
        },
      })
      console.log(this.userID)
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
