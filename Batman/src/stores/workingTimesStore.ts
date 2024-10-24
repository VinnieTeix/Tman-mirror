import { defineStore } from 'pinia'
import { clockInOut, startTimer } from '../services/clockService'
import {
  createWorkingTime,
  deleteWorkingTime,
  getAllDateBetween,
  updateWorkingTime,
} from '../services/workingTimeServices'
import type {
  WorkingTime,
  WorkingTimeData,
  WorkingTimesState,
} from './storesTypes'

export const useWorkingTimesStore = defineStore<
  'workingTimes',
  WorkingTimesState
>({
  id: 'workingTimes',
  state: (): WorkingTimesState => ({
    workingTimes: [],
  }),
  getters: {
    getWorkingTimes: (state: WorkingTimesState) => state.workingTimes,
  },
  actions: {
    async getAllDateBetween(workingTimeData: any) {
      const response = await getAllDateBetween(workingTimeData)
      this.workingTimes = response.data.data
    },

    async createWorkingTime(workingTimeData: WorkingTimeData) {
      const { start, end } = workingTimeData.workingtimes
      const response = await createWorkingTime({ start, end })
      return response.data.data
    },

    async updateWorkingTime(
      workingTimeData: WorkingTimeData,
      workingTimeId: string,
    ) {
      const { start, end } = workingTimeData.workingtimes
      await updateWorkingTime({ start, end }, workingTimeId)

      for (const index in this.workingTimes) {
        if (this.workingTimes[index].id === workingTimeId) {
          this.workingTimes[index].start = start
          this.workingTimes[index].end = end
          break
        }
      }
    },

    async clockInOut(body: any, status: string) {
      const response = await clockInOut(body, status)
      if (response.data.data_wt) {
        this.workingTimes.push(response.data.data_wt)
      }
    },

    async startTimer(id: string, status: string) {
      const response = await startTimer(id, status)
      if (response.data.data_wt) {
        this.workingTimes.push(response.data.data_wt)
      }
    },

    async deleteWorkingTime(workingTimeId: string) {
      await deleteWorkingTime(workingTimeId)
      const content = this.workingTimes.filter(
        (workingTime: WorkingTime) => workingTime.id !== workingTimeId,
      )
      this.workingTimes = content
    },
  },
})
