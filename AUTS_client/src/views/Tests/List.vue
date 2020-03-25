<template>
<v-container>
        <v-row>
            <h2 v-if="current_User.type == 'Admin'">Все тесты</h2>
            <h2 v-else>Мои тесты</h2>
            <v-spacer />
            <v-btn v-if="current_User.type == 'Teacher'" class="success" to="/tests/add">
                Добавить тест
            </v-btn>
        </v-row>
       
        <v-simple-table>
                <template>
                    <thead>
                    <tr>
                        <th>Название теста</th>
                        <th class="text-center" v-if="current_User.type == 'Admin'">Преподаватель</th>
                        <th class="text-center">Количество вопросов</th>
                        <th class="text-center">Темы</th>
                        <th class="text-center">Действия</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="item in tests" :key="item.id">
                        <td>{{ item.name }}</td>
                        <td class="text-center" v-if="current_User.type == 'Admin'">{{ item.teacher.login }}</td>
                        <td class="text-center">{{ item.num_of_quest }}</td>
                        <td class="text-center" v-for="thema in item.themas" :key="thema.id">
                            {{ thema.name}}
                            
                        </td>
                        <td class="text-center">
                            <v-btn class="ma-2 warning" @click="updateTest(item)">Изменить</v-btn>
                            <v-btn class="ma-2 error" @click="deleteTest(item)">Удалить</v-btn>
                        </td>
                    </tr>
                    </tbody>
                </template>
        </v-simple-table>
</v-container>
</template>



<script>
export default {
    name: "Question_List",
    data(){
        return{
            tests: [],
            current_User: this.$store.state.currentUser
        }
    },
    created(){
        this.fetchData()
    },
    methods: {
        fetchData(){
            const role = this.current_User.type
            if( role != "Student"){
                this.$http.secured.get("/"+role.toLowerCase()+"/tests")
                                  .then(resp => this.tests= resp.data)
            }
            else{
                this.$router.replace("/dashboard")
            }
        },
        updateTest(item){
            this.$router.replace(`/tests/${item.id}/edit`)
        },
        deleteTest(item){
            const role = this.current_User.type
            this.$http.secured.delete('/'+role.toLowerCase()+`/tests/${item.id}`)
                              .finally(()=>{
                                   this.tests.splice(this.tests.indexOf(item), 1)
                              })
        },
    }
}
</script>
