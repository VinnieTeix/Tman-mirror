export interface User {
  id: string
  username: string
  email: string
}

export interface LoginBody {
  username: string
  password: string
}

export interface UserBody {
  username: string
  email: string
  password: string
}

export interface WorkingTimeQuery {
  userId: string
  start: string
  end: string
}

export interface WorkingTimeBody {
  start: string
  end: string
}
