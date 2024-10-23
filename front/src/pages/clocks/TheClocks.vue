<template>
    <div>
        <the-navigation/>
            <div class="container">
                <h1>Clocks Page</h1> 
                <div class="cards">
                    <div class="column">
                        <base-card v-if="flag">
                            <button @click="flag = !flag">Clock In</button>
                        </base-card>
                    </div>
                    <div class="column">
                        <base-card v-if="flag == false" >
                            <button @click="flag = !flag">Clock Out</button>
                        </base-card>
                    </div>
                </div>
            </div>
    </div>
</template>
<script>
import TheNavigation from '../../components/nav/TheNavigation.vue';
export default {
    components: {
        TheNavigation
    },
    data() {
        return {
            flag: true
        }
    }
}
</script>
<style scoped>
h1 {
    display: flex;
    align-self: center;
}
.container {
    display: flex;
    flex-direction: column;
}
@media screen and (max-width: 600px) {
  .column {
    width: 100%;
    display: block;
    margin-bottom: 20px;
  }
}
</style>