//= require jquery
//= require jquery_ujs
//= require selectize
//= require moment
//= require datetime_picker
//= require ckeditor/init
//= require_tree .

document.addEventListener("DOMContentLoaded", function(event) {
  if(document.getElementById('category_description_content')){
    CKEDITOR.replace('category_description_content');
  }
});
