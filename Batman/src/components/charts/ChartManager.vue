<template>
  <div id="chartManager">
    <LineChart :data="lineChartData" />
    <BarChart :data="barChartData" />
    <DoughnutChart :data="doughnutChartData" />
  </div>
</template>

<script>
import { useRouter } from "vue-router";
import { useUserStore } from "../../stores/usersStore";
import { useWorkingTimesStore } from "../../stores/workingTimesStore.ts";
import {
  workingTimeByDay,
  workingTimeCountSessions,
  workingTimeFormatDate,
} from "../../utils/workingTimeUtils";
import BarChart from "./BarChart.vue";
import DoughnutChart from "./DoughnutChart.vue";
import LineChart from "./LineChart.vue";

export default {
  name: "chartManager",
  components: {
    BarChart,
    LineChart,
    DoughnutChart,
  },
  async mounted() {
    const userStore = useUserStore();
    const userIsValid = Object.keys(userStore.getUser).length > 0;
    if (!userIsValid) {
      useRouter().push("/login");
      return;
    }
    await useWorkingTimesStore().getAllDateBetween({
      start: "2021-12-09 12:30:05.000",
      end: "2099-12-30 12:30:25.000",
      userId: this.$route.params.id ?? userStore.getUserId,
    });
  },
  computed: {
    lineChartData() {
      const timeWorkingStore = useWorkingTimesStore();
      return workingTimeFormatDate(timeWorkingStore.getWorkingTimes);
    },
    barChartData() {
      const timeWorkingStore = useWorkingTimesStore();
      return workingTimeCountSessions(timeWorkingStore.getWorkingTimes);
    },
    doughnutChartData() {
      const timeWorkingStore = useWorkingTimesStore();
      return workingTimeByDay(timeWorkingStore.getWorkingTimes);
    },
  },
};
</script>

<style>
#chartManager {
  width: 100vw;
  max-width: 1980px;
  height: fit-content;
  padding: 30px;

  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: center;
  gap: 10px;
}
</style>
