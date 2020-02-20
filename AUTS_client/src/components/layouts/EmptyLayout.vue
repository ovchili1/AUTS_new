<template> 
    <v-content>
        <v-container class="dark fill-height" fluid>
            <v-row justify="center" align="center">
                <v-col cols="12" sm="8" md="4">
                    <router-view />
                </v-col>
            </v-row>
        </v-container>
    </v-content>
</template>


<style>
 .dark{
     background: #838383;
 }
</style>