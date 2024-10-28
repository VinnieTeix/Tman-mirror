import { defineStore } from 'pinia'
import axios from 'axios'

export const useGlobalStore = defineStore('global', {
  state: () => ({
    userID: '',
    email: '',
    username: '',
    granted: false,
    userLoggedIn: JSON.parse(localStorage.getItem('userLoggedIn')) || false,
    role: '',
    users: [],
  }),
  actions: {
    setUserLoggedIn(status) {
      this.userLoggedIn = status
      localStorage.setItem('userLoggedIn', JSON.stringify(status))
    },
    initAuth() {
      const storedStatus = JSON.parse(localStorage.getItem('userLoggedIn'))
      if (storedStatus !== null) {
        this.userLoggedIn = storedStatus
      }
    },
    async fetchUsers() {
      // Fetch users from the server and map user IDs to usernames
      const response = await axios.get('http://localhost:4000/api/users'); // Adjust the endpoint accordingly
      const usersData = response.data.data; // Assuming this returns an array of users

      // Create a mapping of user IDs to usernames
      this.users = {};
      usersData.forEach(user => {
        this.users[user.id] = user.username; // Adjust according to your user object structure
      });
    },

    setUserID(newUserID) {
      this.userID = newUserID
    },
    async getUserID() {
      return this.userID
    },

    async getWorkingtimes() {
      try {
        // Fetch data from the API
        const response = await axios.get(`http://localhost:4000/api/clocks/${this.userID}`);
        const clocks = response.data.data;
        console.log(response);

        // Filter events by user ID and separate "start" and "end" events
        const startEvents = clocks.filter(event => event.status === true);
        const endEvents = clocks.filter(event => event.status === false);

        // Array to store paired start and end times
        const result = [];

        // Pair each start event with the closest subsequent end event
        console.log(startEvents);
        console.log(endEvents);
        for (const startEvent of startEvents) {
          const closestEnd = endEvents
              .filter(endEvent => endEvent.time > startEvent.time)
              .sort((a, b) => a.time - b.time)[0]; // Get the closest end event

          if (closestEnd) {
            result.push({
              userID: startEvent.user_id,
              start: startEvent.time,
              end: closestEnd.time,
            });

            // Optionally, remove the matched end event to prevent reuse in pairing
            endEvents.splice(endEvents.indexOf(closestEnd), 1);
          }
        }

        console.log(result);
        return result;
      } catch (error) {
        console.error('Error fetching working times:', error);
        return []; // Return an empty array in case of an error
      }
    },


    async register(values) {
      try {
        const response = await axios.post('http://localhost:4000/api/users', {
          user: {
            username: values.email.split('@')[0], // Ensure username is passed
            email: values.email,
            password: values.password,
            role: values.role, // Convert role to lowercase
          },
        })

        const userData = response.data.data
        this.userID = userData.id
        this.username = values.email.split('@')[0]
        this.setUserLoggedIn(true)
        this.email = values.email
        this.role = values.role
        this.role == 'manager' || this.role == 'admin'
          ? (this.granted = true)
          : (this.granted = false)
        this.initAuth()
        localStorage.setItem('userLoggedIn', JSON.stringify(true))
      } catch (err) {
        console.log(err)
      }
    },
    async authenticate(values) {
      localStorage.setItem('userLoggedIn', JSON.stringify(true))
      this.userID = values.id
      this.username = values.username
      this.email = values.email
      this.role = values.role
      this.role == 'manager' || this.role == 'admin'
        ? (this.granted = true)
        : (this.granted = false)
      console.log(values)
    },
    logout() {
      localStorage.removeItem('userLoggedIn') // Remove userLoggedIn from localStorage
      this.setUserLoggedIn(false) // Set userLoggedIn to false
    },
  },
})
