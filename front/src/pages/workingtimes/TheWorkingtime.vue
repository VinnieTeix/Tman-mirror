<template>
    <div>
    <the-navigation />
        <base-card>
            <ejs-dashboardlayout >
                <e-panels>
                    <e-panel :row="2" :col="3"/>
                </e-panels>
            </ejs-dashboardlayout>
        </base-card>
    <the-calendar />
    </div>
</template>
<script>


import TheNavigation from '../nav/TheNavigation.vue';
import { DashboardLayoutComponent } from '@syncfusion/ej2-vue-layouts';
import { PanelsDirective } from '@syncfusion/ej2-vue-layouts';
import { PanelDirective } from '@syncfusion/ej2-vue-layouts';

export default {
    components: {
        'the-navigation' : TheNavigation,
        'ejs-dashboardlayout': DashboardLayoutComponent,
        'e-panels' : PanelsDirective,
        'e-panel' : PanelDirective
    },
    data() {
        data: new DataManager({
         url: "https://ej2services.syncfusion.com/production/web-services/api/Orders?$top=7",
         adaptor: new WebApiAdaptor()
       })
    }
}
</script>
<style scoped>
@import "../../../node_modules/@syncfusion/ej2-base/styles/material.css";
@import "../../../node_modules/@syncfusion/ej2-vue-layouts/styles/material.css"; 
</style>
