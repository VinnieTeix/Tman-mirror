  <template #layers>
    <Grid strokeDasharray="2,2" />
    <Bar :dataKeys="['name', 'pl']" :barStyle="{ fill: '#90e0ef' }" />
    <Bar :dataKeys="['name', 'avg']" :barStyle="{ fill: '#0096c7' }" />
    <Bar :dataKeys="['name', 'inc']" :barStyle="{ fill: '#48cae4' }" />
    <Marker :value="1000" label="Avg." color="#e76f51" strokeWidth="2" strokeDasharray="6 6" />
  </template>

<script>
export default {};
</script>
