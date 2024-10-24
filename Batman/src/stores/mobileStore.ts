import { defineStore } from 'pinia'
import type { MobileState } from './storesTypes'

export const useMobileStore = defineStore('mobile', {
  state: (): MobileState => ({
    mobile: { offline: {} },
  }),

  getters: {
    getOffline: (state): Record<string, any> => {
      return state.mobile.offline
    },
  },

  actions: {
    setOffline(mobile: Record<string, any>) {
      this.mobile.offline = mobile
    },
  },
})
