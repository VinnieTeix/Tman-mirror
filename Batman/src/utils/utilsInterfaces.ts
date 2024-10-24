export interface ChartData {
  start: string
  end: string
}

export interface Session {
  date: Date
  time: number
}

export interface SessionCount {
  occurences: number
  time: number
}

export interface DayTime {
  day: string
  time: number
}
