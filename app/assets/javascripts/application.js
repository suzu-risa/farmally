// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= stub sell/sell
//= require_tree .

function openDrawer() {
  const drawer = document.querySelector('.navigation__drawer');
  const navigationBurger = document.getElementById('navigationBurger');
  const burgerImage = document.querySelector('#navigationBurger>.burger-image');
  const closeImage = document.querySelector('#navigationBurger>.close-image');

  drawer.classList.add('is-open');

  burgerImage.classList.remove('is-visible');
  closeImage.classList.add('is-visible');

  navigationBurger.removeEventListener('click', openDrawer, false);
  navigationBurger.addEventListener('click', closeDrawer, false);
}

function closeDrawer() {
  const drawer = document.querySelector('.navigation__drawer');
  const navigationBurger = document.getElementById('navigationBurger');
  const burgerImage = document.querySelector('#navigationBurger>.burger-image');
  const closeImage = document.querySelector('#navigationBurger>.close-image');

  drawer.classList.remove('is-open');

  burgerImage.classList.add('is-visible');
  closeImage.classList.remove('is-visible');

  navigationBurger.removeEventListener('click', closeDrawer, false);
  navigationBurger.addEventListener('click', openDrawer, false);
}  

document.addEventListener("DOMContentLoaded", function(event) {
  const navigationBurger = document.getElementById('navigationBurger');
  if (navigationBurger) {
    navigationBurger.addEventListener('click', openDrawer, false);
  }

  const navigationDrawerCloser = document.getElementById('navigationDrawerCloser');

  if (navigationDrawerCloser) {
    navigationDrawerCloser.addEventListener('click', closeDrawer, false);
  }
}, false);
