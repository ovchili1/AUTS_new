<template>
    <v-card>
        <v-toolbar color="primary" dark flat>
            <v-toolbar-title>
                Форма регистрации
            </v-toolbar-title>
        </v-toolbar>
        <v-card-text>
            <v-form @submit="signup">
                <v-text-field prepend-icon="person" label="Логин" v-model="login" required />
                <v-text-field prepend-icon="mail" label="Почта" v-model="email" required />
                <v-text-field prepend-icon="vpn_key" type="password" label="Пароль" v-model="password" required/>
                <v-text-field prepend-icon="vpn_key" type="password" label="Подтверждение пароля" v-model="password_confirm" required/>
            </v-form>
        </v-card-text>
        <v-card-actions>
            <v-spacer/>
            <v-btn color="secondary" to="/signin">Авторизация</v-btn>
            <v-btn color="primary" type="submit" @click="signup">Регистрация</v-btn>
        </v-card-actions>
    </v-card>
</template>

<script>
export default {
    name: 'Login',
    data(){
        return{
            login: '',
            email: '',
            password: '',
            password_confirm: ''
        }
    },
    methods: {
        signup() {
            this.$http.plain
                .post("/signup", {
                    login: this.login,
                    email: this.email,
                    password: this.password,
                    password_confirmation: this.password_confirm
                })
                .then(response => this.signupSuccessful(response))
                .catch(error => this.signupFailed(error));
        },
        signupSuccessful(response) {
            if (response.status != 201) {
                this.signupFailed(response);
                return;
            }
            this.error = "";
            this.$router.replace("/signin");
        },
        signupFailed(error) {
            this.error =
                (error.response && error.response.data && error.response.data.error) ||
                "Something went wrong";
        }
    }
}
</script>