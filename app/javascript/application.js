import Vue from "vue";
import App from "./components/App";
import Search from "./components/SearchField";

Vue.config.productionTip = false;

const isAppMountable = !!document.getElementById("app");
if (isAppMountable) {
  new Vue({
    render: h => h(App)
  }).$mount("#app");
}

new Vue({
  render: h => h(Search)
}).$mount("#search");
