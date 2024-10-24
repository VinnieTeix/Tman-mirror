import type { AxiosInstance } from 'axios'
import axios from 'axios'
import { BASE_URL } from './apiEndpoints'

export const axiosInstance: AxiosInstance = axios.create({
  baseURL: BASE_URL,
})
