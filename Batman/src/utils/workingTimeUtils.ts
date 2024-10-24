import type {
  ChartData,
  DayTime,
  Session,
  SessionCount,
} from './utilsInterfaces'

export const workingTimeFormatDate = (chartsData: ChartData[]): Session[] => {
  return chartsData?.map(chart => {
    const startDate = new Date(chart.start)
    const endDate = new Date(chart.end)
    return {
      date: startDate,
      time: Math.round(
        Math.abs(endDate.getTime() - startDate.getTime()) / 36e5,
      ),
    }
  })
}

export const workingTimeCountSessions = (
  chartsData: ChartData[],
): SessionCount[] => {
  const sessions = workingTimeFormatDate(chartsData)
  const uniques = [...new Set(sessions?.map(item => item.time))]

  const response: SessionCount[] = []

  uniques.forEach(value => {
    const filter = sessions?.filter(session => session.time === value)
    response.push({ occurences: filter?.length ?? 0, time: value })
  })
  return response
}

export const workingTimeByDay = (chartsData: ChartData[]): DayTime[] => {
  const sessions = workingTimeFormatDate(chartsData)
  const response: DayTime[] = []

  for (let i = 0; i < 7; i++) {
    const filtered = sessions?.filter(session => session.date.getDay() === i)
    if (filtered === undefined || filtered.length === 0) continue

    response.push({
      day: filtered[0].date.toLocaleDateString('en-US', { weekday: 'long' }),
      time: filtered.reduce((acc, curr) => acc + curr.time, 0),
    })
  }

  return response
}
