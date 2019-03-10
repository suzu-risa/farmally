//= require ckeditor/init
//= require ./ckeditor_config
//= require ./ckeditor_styles

document.addEventListener("DOMContentLoaded", function(event) {
  if(document.getElementById('category_description_content')){
    CKEDITOR.replace('category_description_content');
  }
});
