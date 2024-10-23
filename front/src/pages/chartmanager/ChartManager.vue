<template>
    <div>
        <the-navigation/>
        <base-card>
            Chart Manager
        </base-card>
    </div>
</template>
<script>
import TheNavigation from '@/components/nav/TheNavigation.vue';


    export default {
        name: "main",
        components: {
            'the-navigation' : TheNavigation,
        }
    }
</script>
<style scoped>
</style>