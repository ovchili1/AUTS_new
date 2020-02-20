<template>
    <v-card>
        <v-toolbar color="primary" dark flat>
            <v-toolbar-title>
                Форма авторизации
            </v-toolbar-title>
        </v-toolbar>
        <v-card-text>
            <v-form>
                <v-text-field prepend-icon="person" label="Логин или почта" v-model.trim="email_login" required />
                <v-text-field prepend-icon="vpn_key" type="password" label="Пароль" v-model.trim="password" required/>
            </v-form>
        </v-card-text>
        <v-card-actions>
            <v-spacer/>
            <v-btn color="secondary" to="/signup">Регистрация</v-btn>
            <v-btn color="primary" @click="signin">Авторизация</v-btn>
        </v-card-actions>
    </v-card>
</template>

<script>
export default {
    name: 'Login',
    data(){
        return{
            email_login: '',
            password: ''
        }
    },
    created() {
        this.checkSignedIn();
    },
    updated() {
        this.checkSignedIn();
    },
    methods: {
        signin() {
            this.$http.plain
                .post("/signin", {
                    email_login: this.email_login,
                    password: this.password
                })
                .then(response => this.signinSuccessful(response))
                .catch(error => this.signinFailed(error));
        },
        signinSuccessful(response) {
        if (!response.data.csrf) {
            this.signinFailed(response);
            return;
        }
        this.$http.plain
            .get("/me")
                .then(meResponse => {
                    this.$store.commit("setCurrentUser", {
                        currentUser: meResponse.data,
                        csrf: response.data.csrf
                });
                    this.error = "";
                    this.$router.replace("/dashboard");
            })
                .catch(error => this.signinFailed(error));
        },
        signinFailed(error) {
            this.error =
                (error.response && error.response.data && error.response.data.error) ||
                "";
            this.$store.commit("unsetCurrentUser");
        },
        checkSignedIn() {
            if (this.$store.state.signedIn) {
                this.$router.replace("/dashboard");
            }
        }
    }
}
</script>