<template>
    <v-container>
        <v-row justify="center" align="center">
            
            <v-form @submit="editUser">
                <v-text-field 
                    prepend-icon="person" 
                    label="Логин" 
                    v-model="user.login" 
                    required />
                <v-text-field 
                    prepend-icon="mail" 
                    label="Почта" 
                    v-model="user.email" 
                    required
                    />
                <v-select
                    v-if="this.bool == false && this.current_User.type == 'Admin' "
                    prepend-icon="mail" 
                    label="Роль"
                    :items="roles"
                    item-text="name"
                    item-value="name"
                    v-model="user.type" 
                    required
                    />
                <v-text-field 
                    prepend-icon="vpn_key" 
                    type="password" 
                    label="Пароль" 
                    v-model="user.password" 
                    required/>
                <v-text-field 
                    prepend-icon="vpn_key" 
                    type="password" 
                    label="Подтверждение пароля" 
                    v-model="user.password_confirmation" 
                    required/>
                <v-row justify="center" align="center">
                    <v-btn type="submit" @click.prevent="editUser">
                        Изменить
                    </v-btn>
                </v-row>
            </v-form>
        </v-row>
    </v-container>
</template>


<script>
export default {
    name: "User_edit",
    data() {
        return {
            current_User: this.$store.state.currentUser,
            bool: false,
            roles: [{name: "Admin"},{name: "Teacher"}, {name: "Student"}],
            user: []
        }
    },
    created(){
        this.fetchData()
    },
    methods:{
        fetchData(){
            if (this.current_User.type == "Admin"){
                const id = this.$route.params.id
                if (id == this.current_User.id){
                    this.bool = true
                }
                this.$http.secured.get("/admin/users/"+id)
                                .then(resp => {
                                    // eslint-disable-next-line no-console
                                    this.user = resp.data
                                })
            }
            else {
                const id = this.current_User.id
                if (id != this.$route.params.id){
                    this.$router.replace("/users/"+id+"/edit")
                }
                else{
                    this.$http.secured.get("/users/"+id)
                                .then(resp => {
                                    this.user = resp.data
                                })
                } 
            }
        },
        editUser(){
            if (this.current_User.type == "Admin"){
                this.$http.plain.put("/admin/users/"+ this.user.id, {user: this.user})
                                // eslint-disable-next-line no-console
                                .then(resp => console.log(resp))
            }
            else{
                this.$http.plain.put("/users/"+ this.user.id, {user: this.user})
                                // eslint-disable-next-line no-console
                                .then(resp => console.log(resp))
            }
        }
    }
}
</script>