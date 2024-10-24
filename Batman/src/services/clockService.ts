import { CLOCK_ENDPOINTS } from '@/router/apiEndpoints'
import { axiosInstance } from '@/router/axiosInstance'

export async function clockInOut(id: string, status: string): Promise<any> {
  return axiosInstance.post(`${CLOCK_ENDPOINTS.CREATE_CLOCK}${id}`, null, {
    params: { status },
  })
}

export async function startTimer(id: string, status: string): Promise<any> {
  return axiosInstance.post(`${CLOCK_ENDPOINTS.CREATE_CLOCK}${id}`, {
    status,
  })
}
