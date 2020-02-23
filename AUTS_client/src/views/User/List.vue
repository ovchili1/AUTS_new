<template>
    <v-container>
        <h2>Все пользователи</h2>
        <v-simple-table>
            <template v-slot:default>
                <thead>
                <tr>
                    <th class="text-left">Логин</th>
                    <th class="text-left">Почта</th>
                    <th class="text-left">Роль</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="item in users" :key="item.id">
                    <td>{{ item.login }}</td>
                    <td>{{ item.email }}</td>
                    <td>{{ item.type }}</td>
                </tr>
                </tbody>
            </template>
        </v-simple-table>
    </v-container>
</template>

<script>
export default {
    name: 'User_list',
    data(){
        return{
            users: [],
            current_User: this.$store.state.currentUser 
        }
    },
    created(){
        this.fetchData()
    },
    methods: {
        fetchData(){
            if (this.current_User.type == "Admin"){
                this.$http.secured.get("/admin/users")
                                  .then(resp => {
                                       // eslint-disable-next-line no-console
                                       resp.data.splice(this.current_User.id - 1 ,1)
                                       this.users = resp.data 
                                  })
            }
            else{
                this.$router.replace("/dashboard")
            }
        }
    }
}
</script>