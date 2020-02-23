<template>
    <v-container>
        <v-row class="flex-column" justify="center" align="center">
            <v-row class="mt-12" >
                <h3 v-if="this.path.indexOf('add')!= '-1'">Добавить тему</h3>
                <h3 v-else> Изменить тему</h3>
            </v-row>
            <v-form @submit="add_Edit">
                <v-text-field 
                    prepend-icon="person"
                    class="pa-15" 
                    label="Название" 
                    v-model="thema.name" 
                    required />
                <v-select
                    :items="teachers"
                    item-text="login"
                    class="pa-15"
                    item-value="id"
                    label="Преподаватель"
                    v-model="thema.teacher_id"
                    v-if="this.current_User.type == 'Admin'"
                />
                
                <v-row justify="center" align="center">
                    <v-btn type="submit" @click.prevent="add_Edit">
                        <span v-if="path.indexOf('add') != '-1'">Добавить</span>
                        <span v-else>Изменить</span>
                    </v-btn>
                </v-row>
            </v-form>
        </v-row>
    </v-container>
</template>


<script>
export default {
    name: 'Add_editThemas',
    data(){
        return{
            teachers: [],
            path: this.$route.path,
            current_User: this.$store.state.currentUser,
            thema: {
                id: '',
                name: '',
                teacher_id : ''
            }
        }
    },
    created(){
        this.check_role()
        this.fetchData()
    },
    methods: {
        check_role(){
            if (this.path.indexOf("add")!= "-1" && this.current_User.type != "Teacher"){
                this.$router.replace("/dashboard")
            }
        },
        fetchData(){
            if (this.path.indexOf("edit")!= "-1"){
                const role = this.current_User.type
                const id = this.$route.params.id
                if (role != "Student"){
                    this.$http.secured.get("/all_teachers")
                                      .then (resp => {
                                          this.teachers = resp.data
                                      })
                    this.$http.secured.get("/"+role.toLowerCase()+"/themas/" + id)
                                      .then(resp => {
                                          this.thema.id = resp.data.id
                                          this.thema.name = resp.data.name
                                          this.thema.teacher_id = resp.data.teacher_id
                                      })
                }
            }
        },
        add_Edit(){
            const role = this.current_User.type
            if (this.path.indexOf("add")!= "-1"){
                this.$http.plain.post("/teacher/themas", {name: this.thema.name, teacher_id: this.current_User.id })
                                .finally(()=>{
                                    this.$router.replace("/themas")
                                })
            }
            else {
                
                this.$http.plain.put("/"+ role.toLowerCase() +"/themas/" + this.thema.id, {thema: this.thema })
                                .finally(()=>{
                                    this.$router.replace("/themas")
                                })
            }
        }
    }
}
</script>