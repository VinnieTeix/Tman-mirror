<template>
  <div>
    <the-navigation />
    <div class="container">
      <h1>Clocks Page</h1>
      <base-card>
        <div class="column">
          <div class="image">
            <img v-if="flag" src="@/assets/img/clock_grey.jpeg" alt="grey" />
            <img v-else src="@/assets/img/red_clock.jpg" alt="grey" />
          </div>
          <Button v-if="flag" @click="clockOut">Clock In</Button>
          <Button v-else @click="clockIn">Clock Out</Button>
        </div>
      </base-card>
    </div>
  </div>
</template>
<script>
import { useGlobalStore } from '@/store/store.js'
import { mapWritableState } from 'pinia'
import TheNavigation from '@/components/nav/TheNavigation.vue'
import Button from '@/components/ui/Button.vue'
import axios from 'axios'

export default {
  components: {
    TheNavigation,
    Button,
  },
  computed: {
    ...mapWritableState(useGlobalStore, ['userLoggedIn']),
  },
  created() {
    const store = useGlobalStore()
    store.initAuth()
    if (!this.userLoggedIn) {
      this.$router.push('/login')
    }
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
      axios.post(`http://localhost:4000/api/clocks/${this.userID}`, {
        clock: {
          status: true,
          time: new Date(),
          user_id: this.userID.toString(),
        },
      })
      console.log(this.userID)
      this.flag = !this.flag
    },
    clockOut() {
      axios.post(`http://localhost:4000/api/clocks/${this.userID}`, {
        clock: {
          status: false,
          time: new Date(),
          user_id: this.userID.toString(),
        }
      // }),
      //
      // axios.get(`http://localhost:4000/api/workingtimes/${this.userID}`,{
      //   workingtime:{
      //     start: ,
      //     end: ,
      //     user_id:
      //
      //   },
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
.image {
  background-color: #fff;
  color: #000;
  border-radius: 5px;
  max-width: 40%;
  max-height: 60%;
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
