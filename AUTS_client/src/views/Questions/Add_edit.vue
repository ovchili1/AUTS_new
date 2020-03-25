<template>
    <v-form>
        <v-container>
            <v-row>
                <v-textarea
                    label="Формулировка вопроса" 
                    v-model="question.quest_body" 
                    required />
            </v-row>
            <v-row>
                <v-select
                label="Тип вопроса"
                :items="types"
                item-text="name"
                item-value="name"  
                v-model="question.quest_type" 
                required/>
            </v-row>
            <v-row>
                <v-select
                label="Тема вопроса"
                :items="themas"
                item-text="name"
                item-value="id"
                v-model="question.thema_id"
            />
            </v-row>
            
            
        </v-container>

        <v-container>
            <v-row>
                <h3>Ответы</h3>
                <v-spacer />
                <v-btn @click="addAnswers" class="success">
                    Добавить
                </v-btn>
            </v-row>
        </v-container>
        <template>
            <v-container>
                <v-row v-for="item in question.answers_attributes" :key="item.id">
                    <v-row v-if="item._destroy != '1'">
                         <v-checkbox
                        v-model="item.right" 
                        hide-details
                        class="shrink"
                        />
                        <v-text-field
                            label="Формулировка ответа" 
                            v-model.trim="item.ans_body" 
                            required />
                        <v-btn
                            text
                            class="shrink"
                            color="red"
                            @click="removeAnswers(item)"
                        >
                        Удалить
                        </v-btn>       
                       
                    </v-row>
                    <v-row v-else>
                        <span>Ответ был удален</span>
                        <v-btn class="ma-1" @click="undoAnswers(item)" >Восстановить</v-btn>
                    </v-row> 
                </v-row>
            </v-container>
        </template>
        <v-container>
            <v-btn @click="add_EditQuestion" v-if="this.path.indexOf('add') != '-1'">
                Добавить вопрос
            </v-btn>
            <v-btn @click="add_EditQuestion" v-else>
                Изменить вопрос
            </v-btn>
        </v-container>
        
    </v-form>
</template>

<script>
export default {
    name: 'Add_editQuestion',
    computed: {
        weight: function(){
            var weight, kol = 0;
            if (this.question.quest_type != "One"){
                this.question.answers_attributes.forEach(ans => {
                    if (ans.right == true) {
                        kol +=1         
                    }
                });
                weight = 1/ kol;
                this.question.answers_attributes.forEach(ans => {
                    if (ans.right == true) {
                        ans.weight = weight         
                    }
                    else{
                        ans.weight = 0
                    }
                });
                return weight; 
            }
            else {
                weight = 1;
                this.question.answers_attributes.forEach(ans => {
                    if (ans.right == true) {
                        ans.weight = weight         
                    }
                    else {
                        ans.weight = 0
                    }
                });
                return weight;
            }
        },
    },
    data(){
        return{
            themas: [],
            path: this.$route.path,
            current_User: this.$store.state.currentUser,
            types:[{name: 'One'}, {name: 'Multiple'}],
            question:{
                quest_body:'',
                quest_type: '',
                thema_id: '',
                teacher_id: '',
                answers_attributes:[]
            }
        }
    },
    updated(){
        this.updated_Add();
    },
    created(){
        this.check_role(),
        this.fetchData()
    },
    methods: {
        add_EditQuestion(){
            if(this.path.indexOf("add") != "-1"){
                this.question.teacher_id = this.current_User.id
                this.$http.plain.post("/teacher/questions", { question: this.question})
                                  // eslint-disable-next-line no-console
                                  .then(resp => this.success_AddEdit(resp))
            }
            else{
                const role = this.current_User.type
                this.$http.plain.put("/"+role.toLowerCase()+"/questions/" + this.question.id, { question: this.question})
                                  // eslint-disable-next-line no-console
                                  .then(resp => this.success_AddEdit(resp))
            }
        },

        updated_Add(){
            this.question.answers_attributes.forEach(ans => {
                    if (ans.right == true) {
                        ans.weight = this.weight         
                    }
                    else{
                        ans.weight = 0
                    }
                });
            
        },

        success_AddEdit(resp){
            if (resp.status == 201){
                this.$router.replace("/dashboard")
            }
            else if (resp.status == 200){
                this.$router.replace("/dashboard")
            }
        },
        check_role(){
            if (this.path.indexOf("add")!= "-1" && this.current_User.type != "Teacher"){
                this.$router.replace("/dashboard")
            }
        },
        fetchData(){
            this.$http.secured.get("/themas")
                                      .then (resp => {
                                          this.themas = resp.data
                                      })
            if (this.path.indexOf("add")  == "-1"){
                const role = this.current_User.type
                const id = this.$route.params.id
                if (role != "Student"){
                    this.$http.secured.get("/"+role.toLowerCase()+"/questions/" + id)
                                      .then(resp => {
                                          this.question.id = resp.data.id
                                          this.question.quest_body = resp.data.quest_body
                                          this.question.quest_type = resp.data.quest_type
                                          this.question.thema_id = resp.data.thema_id
                                          this.question.teacher_id = resp.data.teacher_id
                                          this.question.answers_attributes = resp.data.answers
                                      })
                }
            }
        },
        removeAnswers(index){
            if (this.question.id == ""){
                this.question.answer_attributes.splice(index,1)
            }
            else{
                const ind = this.question.answers_attributes.indexOf(index)
                // eslint-disable-next-line no-console
                console.log(this.question.answers_attributes[ind])
                this.question.answers_attributes[ind]._destroy='1'
            } 
        },
        undoAnswers(index){
            const ind = this.question.answers_attributes.indexOf(index)
            this.question.answers_attributes[ind]._destroy= null       
        },
        addAnswers(){
            this.question.answers_attributes.push({
                id: null,
                ans_body: '',
                right: false,
                weight: 0.0,
                _destroy: null
            })
        }
    }
}
</script>