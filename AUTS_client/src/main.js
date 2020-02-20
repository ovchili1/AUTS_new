import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import { store } from "./store";
import vuetify from "./plugins/vuetify";
import VueAxios from "vue-axios";
import { securedAxiosInstance, plainAxiosInstance } from "./backend/axios";

Vue.use(VueAxios, {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
});
Vue.config.productionTip = false;

new Vue({
  router,
  store,
  vuetify,
  securedAxiosInstance,
  plainAxiosInstance,
  render: h => h(App)
}).$mount("#app");
