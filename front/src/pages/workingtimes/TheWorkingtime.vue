<template>
    <div>
     <the-navigation />
        <base-card>
            Workingtime
        </base-card>
    <the-calendar />
    </div>
</template>
<script>


import TheNavigation from '../../components/nav/TheNavigation.vue';

export default {
    components: {
        'the-navigation' : TheNavigation,
    },
    data() {

    }
}
</script>
<style scoped>
</style>
