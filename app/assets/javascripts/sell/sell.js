
document.addEventListener("DOMContentLoaded", function(event) {
  var elements = document.querySelectorAll("a[href^='tel:']"),
    l = elements.length;
  for (var i = 0; i < l; i++) {
    elements[i].addEventListener("click", function (e) {
      fetch('/sell-call-click').then(res => {});
    });
  }
});
