<template>
  <div class="w-2/2">
    <p>Children</p>
    <div class="grid grid-cols-4 gap-4">
      <div>
        <label for="start" class="flex text-gray-600 mt-2">Start date:</label>
        <input type="datetime-local" id="start" name="trip-start" v-model="selectedStartDate" required
          class="border rounded w-full p-2" />
      </div>
      <div>
        <label for="end" class="flex text-gray-600 mt-2">End date:</label>
        <input type="datetime-local" id="end" name="trip-end" v-model="selectedEndDate" required
          class="border rounded w-full p-2" />
      </div>
    </div>
    <div class="mt-4">
      <button @click="deleteInterval" class="btn btn-red custom-button-color ml-3 m-2">
        Delete
      </button>
      <button @click="updateInterval" class="btn btn-blue custom-button-color">
        Update
      </button>
    </div>
  </div>
  <div class="grid grid-cols-2 gap-4">
    <div class="p-4 border border-gray-300 rounded shadow-md">
      <div class="mb-2 font-bold">Start:</div>
      {{ start }}
    </div>
    <div class="p-4 border border-gray-300 rounded shadow-md">
      <div class="mb-2 font-bold">End:</div>
      {{ end }}
    </div>
  </div>
</template>

<script>
import { ref } from 'vue';
import { useWorkingTimesStore } from '../../stores/workingTimesStore';

export default {
  name: 'WorkingTime',
  props: {
    start: String,
    end: String,
    id: Number,
    required: true,
  },


  setup(props) {
    const selectedStartDate = ref(null);
    const selectedEndDate = ref(null);
    const workingTimeStore = useWorkingTimesStore();

    const updateInterval = async () => {
      const body = {
        workingtimes: {
          start: selectedStartDate.value,
          end: selectedEndDate.value,
        }
      }


      await workingTimeStore.updateWorkingTime(body, props.id);
    };

    const deleteInterval = async () => {
      await workingTimeStore.deleteWorkingTime(props.id);
    };


    return {
      selectedStartDate,
      selectedEndDate,
      updateInterval,
      deleteInterval,

    };
  },

};
</script>

<style>
section>div {
  height: fit-content;
}
</style>
