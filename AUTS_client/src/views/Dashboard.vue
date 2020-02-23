<template>
    <div>
        
    </div>
</template>

<script>
export default {
    name: 'Dashboard',
    data(){
        return{
            current_User: []
        }
    },
    created(){
        this.fetchData();
    },
    methods: {
        fetchData(){
            this.$http.secured.get("/my_profile")
                              // eslint-disable-next-line no-console
                              .then(resp => this.current_User = resp.data)
        }
    }
}
</script>