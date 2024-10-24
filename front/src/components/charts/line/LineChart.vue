<template>
    <div class="chart">
        <Chart
            :data="lineData"
            :size="{ width: 600, height: 300 }"
            :margin="margin"
            :direction="direction">

            <template #layers>
            <Grid strokeDasharray="2,2" />
            <Line :dataKeys="['name', 'pl']" />
            </template>

        </Chart>
    </div>
</template>
<script>
import { Chart, Grid, Line } from 'vue3-charts'
    export default {
        props: {
            lineData: {
                type: Object,
                required: true
            }
        },
    components: {
        Chart,
        Grid,
        Line 
    },
    data() {
        return {
            direction: 'horizontal',
            margin: {
            left: 0,
            top: 20,
            right: 20,
            bottom: 0
            },
        }
    }
}    
</script>
<style></style>