declare module 'vue-chartjs' {
  import { ChartData, ChartOptions } from 'chart.js'
  import { DefineComponent } from 'vue'

  export type ExtendedDataPoint = any

  export interface BarProps {
    data: ChartData<'bar'>
    options?: ChartOptions<'bar'>
  }

  export const Bar: DefineComponent<BarProps>
}
