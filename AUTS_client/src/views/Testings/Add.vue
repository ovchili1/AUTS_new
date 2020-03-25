<template>
    <v-container>
        <div v-for="(quest,index) in selected_questions" :key="index">
            <section v-if="step == index+1">
                <v-input>
                    {{ quest.quest_body}}
                </v-input>
                <v-container v-if="quest.quest_type == 'One'">
                    <v-radio-group v-model="options[index]" v-for="(ans, ind) in quest.answers" :key="ind">
                        <v-radio :label="ans.ans_body" :value="ans"></v-radio>
                    </v-radio-group>
                </v-container>
                <v-container v-else>
                    <v-checkbox multiple v-model="options[index]" :value="ans" v-for="(ans, ind) in quest.answers" :key="ind" :label="ans.ans_body" />
                </v-container>
            </section>
            
        </div>
        <v-pagination
                v-model="step"
                :length="num_of_quest"
        />
       <div class="center" v-if="step == num_of_quest">
           <v-btn @click.prevent="checkTest">
               Закончить
           </v-btn>
       </div>
    </v-container>
   
    
</template>


<script>
export default {
    name: 'Testings_Add',
    data() {
        return{
            step:1,
            path: this.$route.path,
            num_of_quest: 0,
            current_User: this.$store.state.currentUser,
            testing: {
                test_id: '',
                student_id: '',
                percent_Right: 0,
                num_of_right_options: 0,
                num_of_quest: 0,
                assem_questions_attributes: [],
            },
            options: [],
            questions: [],
            selected_questions: [],
        }
    },
    created() {
        this.fetchData()
    },
    methods: {
        addToData(){
            this.testing.assem_questions_attributes = []
            this.selected_questions.forEach(el => {
                this.testing.assem_questions_attributes.push({
                    id: '',
                    quest_body: el.quest_body,
                    right: el.right,
                    assem_answers_attributes: [],
                    assem_options_attributes: []
                })
            });
            this.selected_questions.forEach((el,ind) => {
                el.answers.forEach(e=>{
                    this.testing.assem_questions_attributes[ind].assem_answers_attributes.push({
                        id: '',
                        ans_body: e.ans_body,
                        right: e.right,
                        weight: e.weight
                    })
                })
            })
            this.options.forEach((el,ind)=> {
                if (this.selected_questions[ind].quest_type != "One"){
                    el.forEach(e=>{
                        this.testing.assem_questions_attributes[ind].assem_options_attributes.push({
                            id:'',
                            ans_body: e.ans_body,
                            right: e.right,
                            weight: e.weight
                        })
                    })
                }
                else{
                    this.testing.assem_questions_attributes[ind].assem_options_attributes.push({
                        ans_body: el.ans_body,
                        right: el.right,
                        weight: el.weight
                    })
                }
            })
        },
        checkTest(){
            var options = this.options;
            var i=0;
            var right = 0;
            var quest = this.selected_questions;
            while ( i < quest.length){
                quest[i].right = undefined
                if (quest[i].quest_type == "One")
                {
                    if (options[i].right == true){
                        right += 1 
                        quest[i].right = true
                    }
                    else{
                        quest[i].right = false
                    }
                    
                }
                else{
                    var j = 0;
                    var sum_w = 0;
                    while (j < options[i].length) {
                        if (options[i][j].weight != 0){
                            sum_w += options[i][j].weight
                        }
                        else{
                            quest[i].right = false
                        }
                        j++
                    }
                    var r_sum = Math.floor(sum_w, -3)
                    if (quest[i].right != false && r_sum == 1){
                        right += 1 
                        quest[i].right = true;
                    }
                }
               i++;
            }
            this.addToData();
            this.testing.percent_Right = right / this.num_of_quest * 100;
            this.testing.num_of_right_options = right;
            this.testing.num_of_quest = this.num_of_quest;
            this.$http.secured.post("/student/testings", {testing: this.testing})
                              .then(resp => this.addSuccess(resp))
        },
        addSuccess(resp){
            if (resp.status == 201){
                this.$router.replace("/testings")
            }
        },
        fetchData(){
            var ind = this.path.indexOf("/add") - 1;
            var id = this.path[ind]
            this.testing.test_id = id
            this.testing.student_id = this.current_User.id
            this.$http.secured.get(`student/tests/${id}`)
                              // eslint-disable-next-line no-console
                              .then(resp => this.successAdd(resp))
        },
        successAdd(resp){
            resp.data.themas.forEach(thema => {
                thema.questions.forEach(question => {
                    this.questions.push(question)
                })
            });
            this.num_of_quest = resp.data.num_of_quest
            var i = 0;
            while (i< resp.data.num_of_quest){
                // eslint-disable-next-line no-console
                var rand = this.getRandomIntInclusive(0,this.questions.length-1)
                this.selected_questions.push(this.questions[rand])
                this.questions.splice(rand,1)
                i++;
            }
            
        },
        getRandomIntInclusive(min, max) {
            min = Math.ceil(min);
            max = Math.floor(max);
            return Math.floor(Math.random() * (max - min + 1)) + min; //Максимум и минимум включаются
        },
    }
}
</script>

<style>
    .center{
        text-align: center;
    }
</style>