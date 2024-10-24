import type { UserBody } from '@/services/typesServices'

export interface WorkingTime {
  id: string
  start: string
  end: string
}

export interface WorkingTimeData {
  workingtimes: {
    start: string
    end: string
  }
}

export interface WorkingTimesState {
  workingTimes: WorkingTime[]
}

export interface User {
  id: string
  username: string
  email: string
}

export interface LoginResponse {
  data: {
    user: User
    token: string
  }
}

export interface MobileState {
  mobile: {
    offline: Record<string, any>
  }
}

export interface UserState {
  user: Partial<User>
}

export interface UserActions {
  createUser(userData: UserBody): Promise<Partial<User>>
  setToken(): void
  logout(): void
  login(body: { username: string; password: string }): Promise<void>
  getUserById(id: string): Promise<Partial<User>>
  getUserByUsernameAndEmail(
    username: string,
    email: string,
  ): Promise<Partial<User>>
  decodeToken(): Promise<void>
}
