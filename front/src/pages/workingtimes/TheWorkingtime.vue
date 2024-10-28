<script>
import { useGlobalStore } from '@/store/store.js'
import { mapActions, mapWritableState } from 'pinia'
import FullCalendar from '@fullcalendar/vue3'
import timeGridPlugin from '@fullcalendar/timegrid'
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
    store.fetchUsers()
      .then(() => {
        this.fetchAndSetEvents();
      });
  },
  data() {
    return {
      calendarEvents: [],
      calendarOptions: {
        plugins: [timeGridPlugin, dayGridPlugin, interactionPlugin],
        initialView: 'timeGridWeek',
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'toggleView dayGridWeek,timeGridDay', // Custom toggle button
        },
        customButtons: {
          toggleView: {
            text: 'Toggle View',
            click: this.toggleCalendarView, // Calls toggle method
          }
        },
        events: this.calendarEvents,
        eventClassNames: 'shift-line',
        eventDisplay: 'background',
      },
      currentEvents: [],
    }
  },

  methods: {
    ...mapActions(useGlobalStore, { workingtimes: 'getWorkingtimes' }),

    async fetchAndSetEvents() {
      const store = useGlobalStore();
      const workingTimes = await store.getWorkingtimes();

      this.calendarEvents = workingTimes.map(entry => ({
        title: `${store.users[entry.userID]}'s shift`,
        start: entry.start,
        end: entry.end,
      }));

      this.calendarOptions = { ...this.calendarOptions, events: this.calendarEvents };
    },
    toggleCalendarView() {
      const calendarApi = this.$refs.calendar.getApi();
      const newView = calendarApi.view.type === 'dayGridWeek' ? 'timeGridDay' : 'dayGridWeek';
      calendarApi.changeView(newView); // Change view using the API
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
.fc-event {
  background-color: rgba(0, 123, 255, 0.7); /* Transparent blue background */
  border: none;
}

.fc .fc-timegrid-slot-label-cushion {
  color: #000;
  font-weight: bold;
}

.fc-timegrid-event {
  border-left: 3px solid #007bff; /* Line-like trace for events */
  border-radius: 3px;
}

.fc-timegrid-event .fc-event-title {
  font-weight: bold;
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
  max-width: 1100px;
  margin: 0 auto;
}
</style>

