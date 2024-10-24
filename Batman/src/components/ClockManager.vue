<template>
  <button @click="startTimer" v-if="!isRunning && !startClicked" class="btn btn-blue custom-button-color">
    {{ isClockin ? "Clock-in" : "Log In" }}
  </button>
  <button @click="stopTimer" v-if="isRunning && !stopClicked" class="btn btn-red">
    {{ isClockin ? "Clock-out" : "Log Out" }}
  </button>
</template>

<script>
import { useUserStore } from "../stores/usersStore.ts";
import { useWorkingTimesStore } from "../stores/workingTimesStore";

export default {
  data() {
    return {
      isClockin: true,
      isRunning: false,
      status: false,
      startClicked: false,
      stopClicked: false,
      userStore: useUserStore(),
      workingTimesStore: useWorkingTimesStore(),
    };
  },
  computed: {},
  methods: {
    async startTimer() {
      if (!this.startClicked) {
        this.startClicked = true;
        this.isRunning = true;
        this.status = true;
        this.currentDateTimeIn = this.formattedTime;
        await this.workingTimesStore.startTimer(
          this.$route.params.id ?? this.userStore.getUserId,
          true
        );
      }

      this.timerInterval = setInterval(() => {
        this.elapsedTime = Date.now() - this.startTime;
      }, 10);
    },

    async stopTimer() {
      if (!this.stopClicked) {
        this.stopClicked = true;
        this.isRunning = false;
        this.currentDateTimeOut = this.formattedTimex;
        clearInterval(this.timerInterval);

        await this.workingTimesStore.startTimer(
          this.$route.params.id ?? this.userStore.getUserId,
          false
        );
      }
    },
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
