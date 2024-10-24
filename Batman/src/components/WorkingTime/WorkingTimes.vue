<template>
  <div>
    <p>Selectionner horaire [Parent]</p>

    <label for="start" class="block text-gray-600 mt-4">Start date:</label>
    <input type="datetime-local" id="start" name="trip-start" v-model="selectedStartDate" required min="2023-12-19"
      class="border rounded w-full p-2" />
    <br />

    <label for="end" class="block text-gray-600 mt-4">End date:</label>
    <input type="datetime-local" id="end" name="trip-end" v-model="selectedEndDate" required min="2023-12-27"
      class="border rounded w-full p-2" />

    <button @click="setInterval" class="btn btn-blue custom-button-color">
      Apply
    </button>
  </div>
  <div v-if="dataloaded">
    <div v-for="workingTime in workingTimes">
      <WorkingTime :start="workingTime.start" :end="workingTime.end" :id="workingTime.id" />
    </div>
  </div>
</template>

<script>
import { ref, watch } from "vue";
import { useUserStore } from "../../stores/usersStore";
import { useWorkingTimesStore } from "../../stores/workingTimesStore";
import WorkingTime from "./WorkingTime.vue";

export default {
  name: "WorkingTimes",
  components: {
    WorkingTime,
  },

  setup() {
    const dataloaded = ref(false);
    const workingTimes = ref(null);
    const selectedStartDate = ref("2023-12-19");
    const selectedEndDate = ref("2023-12-26");
    const workingTimeStore = useWorkingTimesStore();
    const chartData = ref([]);

    const setInterval = async () => {
      const start = selectedStartDate.value;
      const end = selectedEndDate.value;
      const userId = this.$route.params.id ?? useUserStore().getUserId;
      await workingTimeStore.getAllDateBetween({ start, end, userId });
      workingTimes.value = workingTimeStore.getWorkingTimes;
      dataloaded.value = true;
    };

    const updateChart = async () => {
      chartData.value = workingTimes.value;
      dataloaded.value = false;
      dataloaded.value = true;
    };

    watch(
      () => workingTimeStore.getWorkingTimes,
      (newWorkingTimes) => {
        workingTimes.value = newWorkingTimes;
      }
    );

    return {
      workingTimes,
      dataloaded,
      selectedStartDate,
      selectedEndDate,
      setInterval,
      updateChart,
    };
  },
};
</script>
<style>
.custom-button-color {
  background-color: #dbf5f5;
  @apply px-5 py-2 text-sm shadow-sm font-medium tracking-wider text-black rounded-md hover:shadow-lg;
  border: 1px solid #ace2e2;
}

.custom-button-color:hover {
  background-color: #ace2e2;
}

.btn-red {
  @apply bg-red-300 border border-red-300 px-5 py-2 text-sm shadow-sm font-medium tracking-wider text-white rounded-md hover:shadow-lg hover:bg-red-400;
}
</style>
