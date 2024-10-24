import { WORKING_TIME_ENDPOINTS } from '@/router/apiEndpoints'
import { axiosInstance } from '@/router/axiosInstance'
import type { WorkingTimeBody, WorkingTimeQuery } from './typesServices'

async function getAllDateBetween(data: WorkingTimeQuery): Promise<any> {
  return axiosInstance.get(
    `${WORKING_TIME_ENDPOINTS.GET_ALL_WORKING_TIME}${data.userId}?start=${data.start}&end=${data.end}`,
  )
}

async function createWorkingTime(
  body: WorkingTimeBody,
  userId: string = '1',
): Promise<any> {
  try {
    const response = await axiosInstance.post(
      WORKING_TIME_ENDPOINTS.CREATE_WORKING_TIME + userId,
      { workingtimes: { start: body.start, end: body.end } },
    )
    console.log('response.data')
    return response.data
  } catch (error) {
    console.error('Erreur lors de la création du working time:', error)
    return null
  }
}

async function updateWorkingTime(
  body: WorkingTimeBody,
  workingTimeId: string,
): Promise<any> {
  return axiosInstance.put(
    WORKING_TIME_ENDPOINTS.CREATE_WORKING_TIME + workingTimeId,
    body,
  )
}

async function deleteWorkingTime(id: string = '1'): Promise<any> {
  return axiosInstance.delete(WORKING_TIME_ENDPOINTS.DELETE_WORKING_TIME + id)
}

export {
  createWorkingTime,
  deleteWorkingTime,
  getAllDateBetween,
  updateWorkingTime,
}
