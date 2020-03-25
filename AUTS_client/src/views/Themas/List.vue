<template>
    <v-container>
        <v-row>
            <h2 v-if="current_User.type == 'Admin'">Все темы</h2>
            <h2 v-else>Мои темы</h2>
            <v-spacer />
            <v-btn v-if="current_User.type == 'Teacher'" class="success" to="/themas/add">
                Добавить тему
            </v-btn>
        </v-row>
       
        <v-simple-table>
                <template>
                    <thead>
                    <tr>
                        <th>Название</th>
                        <th class="text-center" v-if="current_User.type == 'Admin'">Преподаватель</th>
                        <th class="text-center">Количество вопросов</th>
                        <th class="text-center">Количество тестов</th>
                        <th class="text-center">Действия</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="item in themas" :key="item.id">
                        <td>{{ item.name }}</td>
                        <td class="text-center" v-if="current_User.type == 'Admin'">{{ item.teacher.login }}</td>
                        <td class="text-center">{{ item.questions.length }}</td>
                        <td class="text-center">{{ item.tests.length }}</td>
                        <td class="text-center">
                            <v-btn class="ma-2 warning" @click="updateThemas(item)">Изменить</v-btn>
                            <v-btn class="ma-2 error" @click="deleteThemas(item)">Удалить</v-btn>
                        </td>
                    </tr>
                    </tbody>
                </template>
        </v-simple-table>
    </v-container>
    

</template>

<script>
export default {
    name: "Themas_List",
    data(){
        return{
            themas:[],
            current_User: this.$store.state.currentUser
        }
    },
    created(){
        this.fetchData()
    },
    methods:{
        updateThemas(item){
            this.$router.replace(`/themas/${item.id}/edit`)
        },
        deleteThemas(item){
            const role = this.current_User.type
            this.$http.secured.delete('/'+role.toLowerCase()+`/themas/${item.id}`)
                              .finally(()=>{
                                   this.themas.splice(this.themas.indexOf(item), 1)
                              })
        },
        fetchData(){
            const role = this.current_User.type
            if( role != "Student"){
                this.$http.secured.get("/"+role.toLowerCase()+"/themas")
                                  .then(resp => this.themas = resp.data)
            }
            else{
                this.$router.replace("/dashboard")
            }
        }
    }
}
</script>