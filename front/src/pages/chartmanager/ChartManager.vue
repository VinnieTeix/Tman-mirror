<template>
    <div>
        <the-navigation/>
        <div class="chart">
            <div class="bar">
                <bar-chart :bar-data="barData" />
            </div>
            <div class="pie">
                <pie-chart />
            </div>
        </div>
    </div>
</template>
<script>
import TheNavigation from '../../components/nav/TheNavigation.vue';
import BarChart from '../../components/charts/bar/BarChart.vue';
import PieChart from '../../components/charts/pie/PieChart.vue';
import LineChart from '../../components/charts/line/LineChart.vue';


    export default {
        name: "main",
        components: {
            'the-navigation': TheNavigation,
            'bar-chart': BarChart,
            'pie-chart': PieChart,
            'line-chart': LineChart
        },
        data() {
            return {
                barData: [
                    { name: 'Jan', pl: 1000, avg: 500, inc: 300 },
                    { name: 'Feb', pl: 2000, avg: 900, inc: 400 },
                    { name: 'Apr', pl: 400, avg: 400, inc: 500 },
                    { name: 'Mar', pl: 3100, avg: 1300, inc: 700 },
                    { name: 'May', pl: 200, avg: 100, inc: 200 },
                    { name: 'Jun', pl: 600, avg: 400, inc: 300 },
                    { name: 'Jul', pl: 500, avg: 90, inc: 100 }
                ],

            }
        }
    }
</script>
<style scoped>
.bar {
    background-color: #fff;
    color: #000;
}
.pie {
    background-color: #fff;
    color: #000;
}
</style>