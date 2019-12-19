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
//= require_tree .

/**
 * ドロワーオープン時の処理です。
 * メニュー操作のクリックイベントとして使用します。
 */
function openDrawer() {
  var drawer = document.querySelector('.navigation__drawer');
  var navigationBurger = document.getElementById('navigationBurger');
  var burgerImage = document.querySelector('#navigationBurger>.burger-image');
  var closeImage = document.querySelector('#navigationBurger>.close-image');

  drawer.classList.add('is-open');

  burgerImage.classList.remove('is-visible');
  closeImage.classList.add('is-visible');

  navigationBurger.removeEventListener('click', openDrawer, false);
  navigationBurger.addEventListener('click', closeDrawer, false);
}

/**
 * ドロワークローズ時の処理です。
 * メニュー操作のクリックイベントとして使用します。
 */
function closeDrawer() {
  var drawer = document.querySelector('.navigation__drawer');
  var navigationBurger = document.getElementById('navigationBurger');
  var burgerImage = document.querySelector('#navigationBurger>.burger-image');
  var closeImage = document.querySelector('#navigationBurger>.close-image');

  drawer.classList.remove('is-open');

  burgerImage.classList.add('is-visible');
  closeImage.classList.remove('is-visible');

  navigationBurger.removeEventListener('click', closeDrawer, false);
  navigationBurger.addEventListener('click', openDrawer, false);
}  

/**
 * 電話番号のアンカータグにイベントを登録します。
 */
function addTelEvent() {
  var telAnchors = document.querySelectorAll("a[href^='tel:']");
  var telAnchorsList = Array.prototype.slice.call(telAnchors, 0);
  telAnchorsList.forEach(function(telAnchor){
    var tel = telAnchor.getAttribute('href');
    telAnchor.addEventListener('click', function(e){
      fetch('/sell-call-click').then(function(res) {});
      if (yahoo_report_conversion && typeof yahoo_report_conversion === 'function') {
        yahoo_report_conversion(tel);
      }
    });
  });
}

/**
 * メニュー操作のハンバーガーにクリックイベントを登録します。
 */
function addBurgerEvent() {
  var navigationBurger = document.getElementById('navigationBurger');
  if (navigationBurger) {
    navigationBurger.addEventListener('click', openDrawer, false);
  }

  var navigationDrawerCloser = document.getElementById('navigationDrawerCloser');
  if (navigationDrawerCloser) {
    navigationDrawerCloser.addEventListener('click', closeDrawer, false);
  }
}

/**
 * 続きを読むコントローラーを追加します。
 */
function addReadMore() {
  var CLASS_NAME_FOR_REMARK_CLOSE = 'is-close';
  var CLASS_NAME_FOR_BUTTON = 'sale-items__item__context__remark__controller__button';

  var LABEL_TO_OPEN = '続きの文章を開く↓';
  var LABEL_TO_CLOSE = '閉じる↑';

  var MIN_HEIGHT_FOR_REMARK_CLOSE = 600;

  var saleItems = document.querySelectorAll('.sale-items__item');
  var saleItemsList = Array.prototype.slice.call(saleItems, 0);

  saleItemsList.forEach( function(saleItem) {
    var contextArea = saleItem.querySelector('.sale-items__item__context');
    if (contextArea) {
      if (MIN_HEIGHT_FOR_REMARK_CLOSE < contextArea.offsetHeight) {
        var remarkArea = saleItem.querySelector('.sale-items__item__context__remark');
        remarkArea.insertAdjacentHTML('beforeend', 
          '<div class="sale-items__item__context__remark__controller">'
        +     '<input type="button" class="' + CLASS_NAME_FOR_BUTTON + '" value="' + LABEL_TO_OPEN + '" />'
        + '</div>');

        remarkArea.classList.add(CLASS_NAME_FOR_REMARK_CLOSE);
      }
    }
  });

  // ↑で追加した続きの文章を開くボタンにイベントを登録する
  var readMoreButtons = document.querySelectorAll('.' + CLASS_NAME_FOR_BUTTON);
  var readMoreButtonsList = Array.prototype.slice.call(readMoreButtons, 0);
  readMoreButtonsList.forEach( function(readMoreButton){
    readMoreButton.addEventListener('click', function(e) {
      var button = e.target;
      var controller = button.parentNode;
      var remarkContainer = controller.parentNode;

      if (remarkContainer && remarkContainer.classList.contains(CLASS_NAME_FOR_REMARK_CLOSE)) {
        remarkContainer.classList.remove(CLASS_NAME_FOR_REMARK_CLOSE);
        button.value = LABEL_TO_CLOSE;
      } else {
        remarkContainer.classList.add(CLASS_NAME_FOR_REMARK_CLOSE);
        button.value = LABEL_TO_OPEN;
      }
    });
  });
}

document.addEventListener("DOMContentLoaded", function(event) {
  addTelEvent();
  addBurgerEvent();
  addReadMore();
}, false);
