<template>
    <v-container>
        <v-container>
            <v-row>
                <v-spacer />
                <v-col cols="2">
                    <v-btn class="primary" @click.prevent="savePDF" >
                        Скачать PDF
                    </v-btn>
                </v-col>
            </v-row>
        </v-container>
        <v-container id="test">
            <v-list-item three-line>
                <v-list-item-content>
                    <v-list-item-title class="headline mb-1"> {{testing.test.name}}</v-list-item-title>
                    <v-list-item-subtitle>
                        <div>Тест прошел {{testing.student.login}}</div>
                        <div>Результат: {{testing.num_of_right_options}} из {{testing.num_of_quest}}</div>
                    </v-list-item-subtitle>
                </v-list-item-content>    
            </v-list-item>
            <v-container>
                <v-container v-for="quest in testing.assem_questions" :key="quest.id" >
                    <v-container v-if="quest.right==1" class="v-card__success">
                        <v-container>
                            <p>{{ quest.quest_body }}</p>
                            <ul>
                                <li v-for="answ in quest.assem_answers" :key="answ.id">
                                        <span v-for="opt in quest.assem_options" :key="opt.id">
                                            <span v-if="opt.right == true && answ.ans_body == opt.ans_body" class="text-success">{{ answ.ans_body}}</span>
                                            <span v-else-if="opt.right == false && answ.ans_body == opt.ans_body" class="text-warning">{{answ.ans_body}}</span>
                                            <span v-else>{{answ.ans_body}}</span>
                                        </span>
                                </li>
                            </ul>
                        </v-container>
                    </v-container>
                    <v-container v-else class="v-card__warning">
                        <v-container>
                            <p>{{ quest.quest_body }}</p>
                            <ul>
                                <li v-for="answ in quest.assem_answers" :key="answ.id">
                                        <span v-for="opt in quest.assem_options" :key="opt.id">
                                            <span v-if="opt.right == true && answ.ans_body == opt.ans_body" class="text-success">{{ answ.ans_body}}</span>
                                            <span v-else-if="opt.right == false && answ.ans_body == opt.ans_body" class="text-warning">{{answ.ans_body}}</span>
                                            <span v-else>{{answ.ans_body}}</span>
                                        </span>
                                </li>
                            </ul>
                        </v-container>
                    </v-container>
                    
                </v-container>
            </v-container>
        </v-container>

    </v-container>
</template>


<script>
import html2canvas from 'html2canvas'
import * as JsPDF from 'jspdf'
export default {
    name: 'show_Testing',
    data(){
        return{
            id: this.$route.params.id,
            current_User: this.$store.state.currentUser,
            testing: []
        }
    },
    created(){
        this.fetchData();
    },
    methods:{
        saveDOC(element, filename = ''){
                var preHtml = "<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:w='urn:schemas-microsoft-com:office:word' xmlns='http://www.w3.org/TR/REC-html40'><head><meta charset='utf-8'><title>Export HTML To Doc</title></head><body>";
                var postHtml = "</body></html>";
                var html = preHtml+document.getElementById(element).innerHTML+postHtml;

                var blob = new Blob(['\ufeff', html], {
                    type: 'application/msword'
                });
                
                // Specify link url
                var url = 'data:application/vnd.ms-word;charset=utf-8,' + encodeURIComponent(html);
                
                // Specify file name
                filename = filename?filename+'.doc':'document.doc';
                
                // Create download link element
                var downloadLink = document.createElement("a");

                document.body.appendChild(downloadLink);
                
                if(navigator.msSaveOrOpenBlob ){
                    navigator.msSaveOrOpenBlob(blob, filename);
                }else{
                    // Create a link to the file
                    downloadLink.href = url;
                    
                    // Setting the file name
                    downloadLink.download = filename;
                    
                    //triggering the function
                    downloadLink.click();
                }
                
                document.body.removeChild(downloadLink);
        },
        savePDF () {
                html2canvas(document.getElementById('test')).then(canvas => {
                let img = canvas.toDataURL('image/png')
                let pdf = new JsPDF('portrait', 'mm', 'a4')
                pdf.addImage(img, 'JPEG', 5, 5, 200, 287)
                pdf.save('relatorio-remoto.pdf')
            })
        },

        fetchData() {
            const role = this.current_User.type
            if(  role != "Teacher"){
                this.$http.secured.get("/"+role.toLowerCase()+"/testings/"+this.id)
                                    .then(resp => {
                                            // eslint-disable-next-line no-console
                                        this.testing = resp.data;
                                    })
            }
            else{
                this.$router.replace("/dashboard")
            }
        }
    }
}
</script>

<style>
ul li{
    list-style-type: none;
}
.v-card__success{
    border: 5px solid green;
}
.v-card__warning{
    border: 5px solid red;
}
 .text-success{
     color: green
 }
 .text-warning{
     color: red;
 }
</style>
