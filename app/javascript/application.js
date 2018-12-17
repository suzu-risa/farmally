import Vue from "vue";
import App from "./components/App";

import React from "react";
import ReactDOM from "react-dom";
import SaleItemImageSlider from "./react_components/SaleItemImageSlider";

import axios from "axios";

Vue.config.productionTip = false;

const isAppMountable = !!document.getElementById("app");
if (isAppMountable) {
  new Vue({
    render: h => h(App)
  }).$mount("#app");
}

const saleItemImageContainer = document.getElementById("sale-item-image");

if(saleItemImageContainer) {
  document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(<SaleItemImageSlider url={saleItemImageContainer.getAttribute('data-url')}/>, saleItemImageContainer);
  });
}

const searchItemFormCategory = document.getElementById("search_item_form_category");

if(searchItemFormCategory) {
  document.addEventListener('DOMContentLoaded', () => {
    const changeCategoryFieldCallback = function() {
      const categoryCode = searchItemFormCategory.value;

      const subCategoryField = document.getElementById("search_item_form_sub_category");
      while (subCategoryField.firstChild) subCategoryField.removeChild(subCategoryField.firstChild);
      const promptOption = document.createElement("option");
      promptOption.setAttribute("value", "");
      promptOption.textContent = categoryCode ? "全て" : "カテゴリーを選択してください";
      subCategoryField.appendChild(promptOption);


      if(categoryCode) {
        subCategoryField.removeAttribute("disabled");

        axios.get("/sub_categories?category_code=" + categoryCode)
        .then((res) => {
          res.data.sub_categories.forEach(function(sub_category){
            var option = document.createElement("option");
            option.setAttribute("value", sub_category.code);
            option.textContent = sub_category.name;
            subCategoryField.appendChild(option);
          });
        })
        .catch(console.error);
      } else {
        subCategoryField.setAttribute("disabled", "disabled");
      }
    }

    changeCategoryFieldCallback();

    searchItemFormCategory.addEventListener('change', changeCategoryFieldCallback);
  });
}
