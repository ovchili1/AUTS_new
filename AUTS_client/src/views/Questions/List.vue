<template>
<v-container>
        <v-row>
            <h2 v-if="current_User.type == 'Admin'">Все вопросы</h2>
            <h2 v-else>Мои вопросы</h2>
            <v-spacer />
            <v-btn v-if="current_User.type == 'Teacher'" class="success" to="/questions/add">
                Добавить вопрос
            </v-btn>
        </v-row>
       
        <v-simple-table>
                <template>
                    <thead>
                    <tr>
                        <th>Описание вопроса</th>
                        <th class="text-center" v-if="current_User.type == 'Admin'">Преподаватель</th>
                        <th class="text-center">Тип вопроса</th>
                        <th class="text-center">Тема</th>
                        <th class="text-center">Действия</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="item in questions" :key="item.id">
                        <td v-if="item.quest_body.length > 40">{{ item.quest_body.slice(0,40)+"..." }}</td>
                        <td v-else>{{item.quest_body}}</td>
                        <td class="text-center" v-if="current_User.type == 'Admin'">{{ item.teacher.login }}</td>
                        <td v-if="item.quest_type == 'One'" class="text-center">Одиночный</td>
                        <td v-else class="text-center">Множественный</td>
                        <td class="text-center">{{ item.thema.name }}</td>
                        <td class="text-center">
                            <v-btn class="ma-2 warning" @click="updateQuestion(item)">Изменить</v-btn>
                            <v-btn class="ma-2 error" @click="deleteQuestion(item)">Удалить</v-btn>
                        </td>
                    </tr>
                    </tbody>
                </template>
        </v-simple-table>
</v-container>
</template>



<script>
export default {
    name: 'Question_List',
    data(){
        return{
            questions: [],
            current_User: this.$store.state.currentUser
        }
    },
    created(){
        this.fetchData();
    },
    methods: {
        fetchData(){
            const role = this.current_User.type
            if( role != "Student"){
                this.$http.secured.get("/"+role.toLowerCase()+"/questions")
                                  .then(resp => this.questions = resp.data)
            }
            else{
                this.$router.replace("/dashboard")
            }
        },
        updateQuestion(item){
            this.$router.replace(`/questions/${item.id}/edit`)
        },
        deleteQuestion(item){
            const role = this.current_User.type
            this.$http.secured.delete('/'+role.toLowerCase()+`/questions/${item.id}`)
                              .finally(()=>{
                                   this.questions.splice(this.questions.indexOf(item), 1)
                              })
        },
    }
    
}
</script>