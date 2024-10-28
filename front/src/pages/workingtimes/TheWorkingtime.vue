<script>
import { useGlobalStore } from '@/store/store.js'
import {mapActions, mapWritableState} from 'pinia'
import FullCalendar from '@fullcalendar/vue3'
import dayGridPlugin from '@fullcalendar/daygrid'
import interactionPlugin from '@fullcalendar/interaction'
import TheNavigation from '@/components/nav/TheNavigation.vue'

export default {
  name: 'workingtimes',
  components: {
    TheNavigation,
    FullCalendar,
  },
  computed: {
    ...mapWritableState(useGlobalStore, ['userLoggedIn', 'granted']),
  },
  created() {
    const store = useGlobalStore()
    store.getWorkingtimes()
    if (!this.userLoggedIn) {
      this.$router.push('/login')
    }
    if (!this.granted) {
      this.$router.push('/clocks')
    }
    store.fetchUsers() // Fetch users when the component is created
      .then(() => {
        this.fetchAndSetEvents(); // Fetch events after users are fetched
      });
  },
  data: function () {
    return {
      calendarEvents: [], // Array to hold FullCalendar events
      calendarOptions: {
        plugins: [dayGridPlugin, interactionPlugin],
        initialView: 'dayGridWeek',
        events: this.calendarEvents,
      },
      currentEvents: [],
    }
  },

  methods: {
      ...mapActions(useGlobalStore, { workingtimes: 'getWorkingtimes' }),

    handleWeekendsToggle() {
      this.calendarOptions.weekends = !this.calendarOptions.weekends // update a property
    },
    async fetchAndSetEvents() {
      const store = useGlobalStore(); // Get the store instance
      const workingTimes = await store.getWorkingtimes();

      this.calendarEvents = workingTimes.map(entry => ({
        title: `${store.users[entry.user_id]}'s shift`, // Set title based on user ID
        start: new Date(entry.start).toISOString(),
        end: new Date(entry.end).toISOString(),
      }));
      this.calendarOptions = { ...this.calendarOptions, events: this.calendarEvents };
    },
  },
}
</script>

<template>
  <the-navigation />
  <div class="demo-app">
    <div class="demo-app-main">
      <FullCalendar class="demo-app-calendar" :options="calendarOptions">
        <template v-slot:eventContent="arg">
          <b>{{ arg.timeText }}</b>
          <i>{{ arg.event.title }}</i>
        </template>
      </FullCalendar>
    </div>
  </div>
</template>

<style lang="css">
h2 {
  margin: 0;
  font-size: 16px;
}

ul {
  margin: 0;
  padding: 0 0 0 1.5em;
}

li {
  margin: 1.5em 0;
  padding: 0;
}

b {
  /* used for event dates/times */
  margin-right: 3px;
}

.demo-app {
  display: flex;
  min-height: 100%;
  font-family:
    Arial,
    Helvetica Neue,
    Helvetica,
    sans-serif;
  font-size: 14px;
}

.demo-app-calendar {
  color: #000000;
  background: #ffffff;
}

.demo-app-sidebar {
  width: 300px;
  line-height: 1.5;
  background: #eaf9ff;
  border-right: 1px solid #d3e2e8;
}

.demo-app-sidebar-section {
  padding: 2em;
}

.demo-app-main {
  flex-grow: 1;
  padding: 3em;
}

.fc {
  /* the calendar root */
  max-width: 1100px;
  margin: 0 auto;
}
</style>
