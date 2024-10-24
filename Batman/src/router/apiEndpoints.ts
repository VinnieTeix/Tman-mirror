export const BASE_URL = "http://localhost:4000" as string
const USER = '/users'
const AUTH = '/auth'
const WORKING_TIME = '/workingtime'
const CLOCK = '/clocks'

function buildApiUrl(path: string): string {
  return `${BASE_URL}/api${path}`
}

export const AUTH_ENDPOINTS = {
  LOGIN: buildApiUrl(AUTH + '/login'),
  CREATE_USER: buildApiUrl(USER),
} as const

export const USER_ENDPOINTS = {
  GET_USER_BY_USERNAME_AND_EMAIL: buildApiUrl(USER),
  GET_USER_BY_ID: (id: string) => buildApiUrl(`${USER}/${id}`),
  UPDATE_USER: (id: string) => buildApiUrl(`${USER}/${id}`),
  DELETE_USER: (id: string) => buildApiUrl(`${USER}/${id}`),
} as const

export const WORKING_TIME_ENDPOINTS = {
  GET_ALL_WORKING_TIME: (userId: string) =>
    buildApiUrl(`${WORKING_TIME}/${userId}`),
  GET_WORKING_TIME_BY_USER_AND_ID: (userId: string, workingTimeId: string) =>
    buildApiUrl(`${WORKING_TIME}/${userId}/${workingTimeId}`), 
  CREATE_WORKING_TIME: (userId: string) =>
    buildApiUrl(`${WORKING_TIME}/${userId}`),
  UPDATE_WORKING_TIME: (workingTimeId: string) =>
    buildApiUrl(`${WORKING_TIME}/${workingTimeId}`),
  DELETE_WORKING_TIME: (workingTimeId: string) =>
    buildApiUrl(`${WORKING_TIME}/${workingTimeId}`),
} as const

export const CLOCK_ENDPOINTS = {
  GET_ALL_CLOCK: (userId: string) => buildApiUrl(`${CLOCK}/${userId}`),
  CREATE_CLOCK: (userId: string) => buildApiUrl(`${CLOCK}/${userId}`),
} as const
