<template>
    <div>
        <the-navigation/>
        <div class="container">
            <h1>Clocks Page</h1> 
            <div class="column">
                <line-chart :line-data="data" />
                <base-card>
                    <button v-if="flag" @click="toggleFlag">Clock In</button>
                    <button v-else @click="toggleFlag">Clock Out</button>
                </base-card>
            </div>
        </div>
    </div>
</template>
<script>

import TheNavigation from '../../components/nav/TheNavigation.vue';
import LineChart from '../../components/charts/line/LineChart.vue';

export default {
    components: {
        TheNavigation,
        LineChart,
    },
    data() {
        return {
            flag: true,
            data: [
                { name: 'Mon', pl: 7 },
                { name: 'Tue', pl: 8 },
                { name: 'Wed', pl: 5 },
                { name: 'Thu', pl: 9 },
                { name: 'Fri', pl: 4 },
                { name: 'Sat', pl: 6 },
                { name: 'Sun', pl: 7 }
            ],
        }
    },
    methods: {
        toggleFlag() {
            this.flag = !this.flag
        }
    }
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
.chart {
    background: #fff;
    color: #000;
    border-radius: 4%;
}

@media screen and (max-width: 600px) {
    .column {
    width: 100%;
    display: block;
    margin-bottom: 20px;
  }
}
</style>