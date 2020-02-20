<template>
  <v-app>
    <component :is="layout">
      <router-view />
    </component>
  </v-app>
</template>
<script>
import EmptyLayout from '@/components/layouts/EmptyLayout.vue'
import MainLayout from '@/components/layouts/MainLayout.vue'
export default {
  name: 'App',
  computed: {
    layout(){
      return (this.$route.meta.layout || 'empty')+'-layout'
    }
  },
  components:{
    EmptyLayout, MainLayout
  },
};
</script>
