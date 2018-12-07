import Vue from "vue";
import App from "./components/App";
import Search from "./components/SearchField";

import React from "react";
import ReactDOM from "react-dom";
import SaleItemImageSlider from "./react_components/SaleItemImageSlider";

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

const saleItemImageContainer = document.getElementById("sale-item-image");

if(saleItemImageContainer) {
  document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(<SaleItemImageSlider url={saleItemImageContainer.getAttribute('data-url')}/>, saleItemImageContainer);
  });
}
