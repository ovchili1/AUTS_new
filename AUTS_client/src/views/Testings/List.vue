<template>
    <v-container>
        <v-container v-if="current_User.type == 'Student'">
            <h3>Список тестов</h3>
            <v-row>
                <v-col cols="3">
                    <v-card v-for="item in tests" :key="item.id">
                        <v-card-title class="headline">
                            {{item.name}}
                        </v-card-title>
                        <v-card-subtitle>
                            Создал: {{item.teacher.login}}
                        </v-card-subtitle>
                        <v-card-text>
                            <div>Состоит из {{item.num_of_quest}} вопросов</div>
                            <div>
                                Темы: 
                                <span v-for="thema in item.themas" :key="thema">
                                    {{ thema.name}}
                                </span>
                            </div>
                        </v-card-text>
                        <v-card-actions>
                            <v-spacer />
                            <v-btn class="success" @click="Add(item)">Пройти тест</v-btn>
                        </v-card-actions>
                    </v-card>
                </v-col>
            </v-row>
        </v-container>
        <v-container v-if="this.testings.length != 0">
            <h3>Список пройденных тестов</h3>
            <v-row>
                <v-col cols="4" v-for="testing in testings" :key="testing.id">
                    <v-card>
                        <v-list-item three-line>
                            <v-list-item-content>
                                <v-list-item-title class="headline mb-1"> {{testing.test.name}}</v-list-item-title>
                                <v-list-item-subtitle>
                                    <div>Тест прошел {{testing.student.login}}</div>
                                    <div>Результат: {{testing.num_of_right_options}} из {{testing.num_of_quest}}</div>
                                </v-list-item-subtitle>
                            </v-list-item-content>
                            <v-list-item-avatar
                                size="100"
                            >
                                <v-progress-circular :rotate="270" :value="testing.percent_Right" :width="10" :size="100" color="primary">
                                    {{ testing.percent_Right}}
                                </v-progress-circular>
                            </v-list-item-avatar>
                            
                        </v-list-item>
                        <v-card-actions>
                                <v-spacer />
                                <v-btn class="success" :to="`/testings/`+testing.id">
                                    Посмотреть результаты
                                </v-btn>
                            </v-card-actions>
                    </v-card>
                </v-col>
            </v-row>
        </v-container>
    </v-container>
    
</template>


<script>
export default {
    name: 'List_Testings',
    data(){
        return {
            current_User: this.$store.state.currentUser,
            tests: [],
            testings: []
        }
    },

    created(){
        this.fetchData()
    },
    methods: {
        Add(item){
            this.$router.replace("/tests/"+ item.id + "/add")
        },
        fetchData() {
            const role = this.current_User.type
            if(  role != "Teacher"){
                this.$http.secured.get("/"+role.toLowerCase()+"/testings")
                                  .then(resp => {
                                      // eslint-disable-next-line no-console
                                      this.testings = resp.data[0].testings
                                      this.tests = resp.data[0].tests
                                  })
            }
            else{
                this.$router.replace("/dashboard")
            }
        }
    }
}
</script>