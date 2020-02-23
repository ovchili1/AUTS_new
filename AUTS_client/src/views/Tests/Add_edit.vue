<template>
    <v-form>
        <v-container>
            <v-row>
                <v-text-field
                    label="Формулировка вопроса" 
                    v-model="test.name" 
                    required />
            </v-row>
            <v-row>
                <v-select
                label="Темы теста"
                :items="themas"
                item-text="name"
                multiple
                return-object
                v-model="test.themas"
            />
            </v-row>
            <v-row>
                <v-text-field
                label="Количество вопросов"
                type="number"
                :min= "1"
                :max= this.maxCount
                :value="1"
                v-model="test.num_of_quest" 
                required/>
            </v-row>

            
            
        </v-container>

        <v-container>
            <v-btn>
                Добавить вопрос
            </v-btn>
        </v-container>
        
    </v-form>
</template>

<script>
export default {
    name: 'Add_editQuestion',
    computed: {
       maxCount: function(){
            var maxCount = 0;
            var i = 0;
            while (i< this.test.themas.length )
            {
                var thema = this.test.themas[i]
                maxCount += thema.questions.length
                i++
            }
            
            
            return maxCount;
        },
    },
    data(){
        return{
            themas: [],
            path: this.$route.path,
            current_User: this.$store.state.currentUser,
            types:[{name: 'One'}, {name: 'Multiple'}],
            test:{
                name:'',
                num_of_quest: '',
                themas: [],
                teacher_id: '',
            }
        }
    },
    created(){
        this.check_role(),
        this.fetchData()
    },
    methods: {
        add_EditTest(){
            if(this.path.indexOf("add") != "-1"){
                this.question.teacher_id = this.current_User.id
                this.$http.plain.post("/teacher/tests", { question: this.question})
                                  // eslint-disable-next-line no-console
                                  .then(resp => console.log(resp))
            }
            else{
                const role = this.current_User.type
                this.$http.plain.put("/"+role.toLowerCase()+"/tests/" + this.test.id, { test: this.test})
                                  // eslint-disable-next-line no-console
                                  .then(resp => console.log(resp))
            }
        },
        check_role(){
            if (this.path.indexOf("add")!= "-1" && this.current_User.type != "Teacher"){
                this.$router.replace("/dashboard")
            }
        },
        fetchData(){
            if (this.test.id == null){
                this.$http.secured.get("/themas")
                                  // eslint-disable-next-line no-console
                                  .then(resp => this.themas = resp.data)
            }
            
            
        },
        
    }
}
</script>