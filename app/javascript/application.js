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

var slick_slide_items = document.querySelectorAll('.' + "slick-slide-container");
if (slick_slide_items) {
  slick_slide_items.forEach(function(slick_slide_item, i){
    var saleItemImageContainer = document.getElementById("sale-item-image" + (i + 1));
    document.addEventListener("DOMContentLoaded", () => {
      ReactDOM.render(<SaleItemImageSlider url={saleItemImageContainer.getAttribute('data-url')}/>, saleItemImageContainer);
    });
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

const newItemForm = document.getElementById("new_item");

if(newItemForm) {
  const categoryField = document.getElementById("item_category_id");
  document.addEventListener('DOMContentLoaded', () => {
    const changeCategoryFieldCallback = function() {
      const categoryId = categoryField.value;

      const subCategoryField = document.getElementById("item_sub_category_id");
      while (subCategoryField.firstChild) subCategoryField.removeChild(subCategoryField.firstChild);
      const promptOption = document.createElement("option");
      promptOption.setAttribute("value", "");
      promptOption.textContent = categoryId ? "" : "カテゴリーを選択してください";
      subCategoryField.appendChild(promptOption);

      if(categoryId) {
        subCategoryField.removeAttribute("disabled");

        axios.get("/sub_categories?category_id=" + categoryId)
        .then((res) => {
          res.data.sub_categories.forEach(function(sub_category){
            var option = document.createElement("option");
            option.setAttribute("value", sub_category.id);
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

    categoryField.addEventListener('change', changeCategoryFieldCallback);
  });
}
