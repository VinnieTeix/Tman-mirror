import { defineStore } from 'pinia'

export const useGlobalStore = defineStore('global', {
  state: () => ({
    userID: '',
  }),
  actions: {
    setUserID(newUserID) {
      this.userID = newUserID
    },
    actions: {
      async getUserID() {
        const response = await this.uesrID.get('get-dates')
        console.log(response.data)
      },
    },
  },
})
