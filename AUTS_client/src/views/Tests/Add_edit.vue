<template>
    <v-form>
        <v-container>
            <v-row>
                <v-text-field
                    label="Название теста" 
                    v-model="test.name" 
                    required />
            </v-row>
            <v-row>
                <v-autocomplete
                chips
                deletable-chips
                hide-selected
                label="Темы теста"
                :items="themas"
                item-text="name"
                return-object
                multiple
                v-model="select_themas"
            />
            </v-row>
            <v-row>
                <v-text-field
                label="Количество вопросов"
                type="number"
                :min= 0
                :max= this.maxCount
                :value="1"
                persistent-hint
                :hint = this.max_Count
                v-model="test.num_of_quest"
                required/>
            </v-row>

            
            
        </v-container>

        <v-container>
            <v-btn @click="add_EditTest" class="success">
                Добавить тест
            </v-btn>
        </v-container>
        
    </v-form>
</template>

<script>
export default {
    name: 'Add_editTest',
    computed: {
       maxCount: function(){
            var maxCount = 0;
            var i = 0;
            while (i< this.select_themas.length )
            {
                var thema = this.select_themas[i]
                maxCount += thema.questions.length
                i++
            }
            
            
            return maxCount;
        },
    },
    data(){
        return{
            themas: [],
            select_themas: [],
            max_Count: "Максимальное количество вопросов - " + this.maxCount,
            path: this.$route.path,
            current_User: this.$store.state.currentUser,
            test:{
                name:'',
                num_of_quest: '',
                thema_ids: [],
                teacher_id: '',
            }
        }
    },
    created(){
        this.check_role(),
        this.fetchData(),
        this.updateResp()
    },
    updated(){
        this.max_Count = "Максимальное количество вопросов - " + this.maxCount
        this.updateResp()
    },
    methods: {
        updateResp(){
            var i = 0;
            var ids = []
            while (i < this.select_themas.length){
                ids.push(this.select_themas[i].id)
                i++; 
            }
            this.test.thema_ids = ids
        },
        add_EditTest(){
            if(this.path.indexOf("add") != "-1"){
                this.test.teacher_id = this.current_User.id
                this.$http.plain.post("/teacher/tests", { test: this.test})
                                  .then(resp => this.success_AddEdit(resp))
            }
            else{
                const role = this.current_User.type
                this.$http.plain.put("/"+role.toLowerCase()+"/tests/" + this.test.id, { test: this.test})
                                  .then(resp => this.success_AddEdit(resp))
            }
        },
        success_AddEdit(resp){
            if (resp.status == 201 || resp.status == 200){
                this.$router.replace("/dashboard")
            }
        },
        check_role(){
            if (this.path.indexOf("add")!= "-1" && this.current_User.type != "Teacher"){
                this.$router.replace("/dashboard")
            }
        },
        fetchData(){
            if (this.test.id == ""){
                this.$http.secured.get("/themas")
                                  // eslint-disable-next-line no-console
                                  .then(resp => this.themas = resp.data)
            }
            else{
                this.$http.secured.get("/themas")
                                  // eslint-disable-next-line no-console
                                  .then(resp => this.themas = resp.data)
                const role = this.current_User.type
                const id = this.$route.params.id
                if (role != "Student"){
                    this.$http.secured.get("/"+role.toLowerCase()+"/tests/" + id)
                                      .then(resp => {
                                          this.test.id = resp.data.id
                                          this.test.name = resp.data.name
                                          this.test.teacher_id = resp.data.teacher_id
                                          this.test.num_of_quest = resp.data.num_of_quest
                                          this.select_themas = resp.data.themas
                                      })
                }
            }
            
            
        },
        
    }
}
</script>