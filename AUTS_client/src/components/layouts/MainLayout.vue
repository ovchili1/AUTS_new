<template>
<div>
    <v-navigation-drawer
        v-model="drawer"
        app
        temporary
        >
        <v-layout column align-center>
            <v-flex class="mt-5">
                <p class="subheading mt-1"> {{ this. current_User.login}}</p>
            </v-flex>
        </v-layout>
        <v-divider />
        <v-list v-if="current_User.type == 'Admin'">
             <v-list-item  v-for="item in links_admin" :key="item.name" :to="item.path">
                <v-list-item-icon>
                    <v-icon v-text="item.icon" />
                </v-list-item-icon>
                <v-list-item-content>
                   <v-list-item-title v-text="item.name" />
                </v-list-item-content>
            </v-list-item>
        </v-list>
        <v-list v-else-if="current_User.type == 'Teacher'">
            <v-list-item  v-for="item in links_teachers" :key="item.name" :to="item.path">
                <v-list-item-icon>
                    <v-icon v-text="item.icon" />
                </v-list-item-icon>
                <v-list-item-content>
                   <v-list-item-title v-text="item.name" />
                </v-list-item-content>
            </v-list-item>
        </v-list>
        <v-list v-else>
            <v-list-item  v-for="item in links_students" :key="item.name" :to="item.path">
                <v-list-item-icon>
                    <v-icon v-text="item.icon" />
                </v-list-item-icon>
                <v-list-item-content>
                   <v-list-item-title v-text="item.name" />
                </v-list-item-content>
            </v-list-item>
        </v-list>
        </v-navigation-drawer>

        <v-app-bar
        app
        color="primary"
        dark
        >
        <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
        <v-toolbar-title>AUTS</v-toolbar-title>
        <v-spacer/>
        <v-btn class="text-capitalize ma-1" @click="logOut" icon>
            <v-icon>
                exit_to_app
            </v-icon>
        </v-btn>
        </v-app-bar>

        <v-content>
            <router-view />
        </v-content>
        <v-footer
        color="primary"
        app
        >
        <span class="white--text">&copy; 2019</span>
        </v-footer>
    </div>
</template>

<script>
export default {
    data(){
        return{
            drawer: '',
            current_User: this.$store.state.currentUser,
            links_students:[ 
                {
                    name: 'Testings',
                    path: '/testings',
                    icon: 'book'
                },
            ],
            links_teachers:[
                {
                    name: 'Themas',
                    path: '/themas',
                    icon: 'bookmarks'
                },
                {
                    name: 'Questions',
                    path: '/questions',
                    icon: 'help'
                },
                {
                    name: 'Tests',
                    path: '/tests',
                    icon: 'casino'
                },
            ],
            links_admin:[
                {
                    name: 'Users',
                    path: '/users',
                    icon: 'account_circle'
                },
                {
                    name: 'Themas',
                    path: '/themas',
                    icon: 'bookmarks'
                },
                {
                    name: 'Questions',
                    path: '/questions',
                    icon: 'help'
                },
                {
                    name: 'Tests',
                    path: '/tests',
                    icon: 'casino'
                },
                {
                    name: 'Testings',
                    path: '/testings',
                    icon: 'book'
                }
            ]
        }
    },
    methods: {
        logOut () {
            this.$http.secured.delete('/signin')
                .then(response => {
                    if (response.status == 200){
                        this.$store.commit('unsetCurrentUser')
                        this.$router.replace('/')
                    }
                })
                .catch(error => this.setError(error, 'Cannot sign out'))
    },
    }
}
</script>

<style>
    
</style>