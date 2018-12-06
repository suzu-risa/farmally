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

document.addEventListener("DOMContentLoaded", function(event) {
  // Get all "navbar-burger" elements
  const $navbarBurgers = Array.prototype.slice.call(
    document.querySelectorAll(".navbar-burger"),
    0
  );

  // Check if there are any navbar burgers
  if ($navbarBurgers.length > 0) {
    // Add a click event on each of them
    $navbarBurgers.forEach(el => {
      el.addEventListener("click", () => {
        // Get the target from the "data-target" attribute
        const target = el.dataset.target;
        const $target = document.getElementById(target);

        // Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
        el.classList.toggle("is-active");
        $target.classList.toggle("is-active");
      });
    });
  }

  // Delete a notification
  var deleteButton = document.getElementsByClassName("delete")[0];
  if (deleteButton) {
    deleteButton.addEventListener("click", function() {
      var notificationElem = document.getElementsByClassName("notification")[0];
      if (notificationElem) {
        notificationElem.parentNode.removeChild(notificationElem);
      }
    });
  }

  // Give five grade evaluation
  const reviewStarOptions = [
    "unselected",
    "very_bad",
    "bad",
    "normal",
    "good",
    "very_good"
  ];
  const stars = Array.from(document.getElementsByClassName("review-star"));
  stars.forEach((star, i) => {
    star.addEventListener("click", () => {
      const point = document.querySelectorAll(".review-star > .fas").length;
      if (i === point - 1) {
        stars.forEach(s => {
          s.firstElementChild.classList.remove("fas");
          s.firstElementChild.classList.add("far");
        });
        document.getElementById("review_star").value = reviewStarOptions[0];
      } else {
        stars.forEach((s, j) => {
          if (j <= i) {
            s.firstElementChild.classList.add("fas");
            s.firstElementChild.classList.remove("far");
          } else {
            s.firstElementChild.classList.remove("fas");
            s.firstElementChild.classList.add("far");
          }
        });
        document.getElementById("review_star").value = reviewStarOptions[i + 1];
      }
    });
  });

  const reviewPic = document.getElementById("review_picture");
  if (reviewPic) {
    reviewPic.addEventListener("change", function(e) {
      document.getElementById("uv").value = e.currentTarget.files[0].name;
    });
  }

  const readMoreButtons = Array.from(
    document.getElementsByClassName("read-more")
  );
  readMoreButtons.forEach((btn, i) => {
    const type = btn.dataset.type;
    btn.addEventListener("click", function(e) {
      const id = btn.dataset.id;
      const readMoreContent = document.getElementById(
        `read-more-${type}-${id}`
      );
      readMoreContent.classList.remove("hide");
      const readLessButton = document.getElementById(
        `read-less-${type}-button-${id}`
      );
      readLessButton.classList.remove("hide");
      btn.classList.add("hide");
    });
  });

  const readLessButtons = Array.from(
    document.getElementsByClassName("read-less")
  );
  readLessButtons.forEach((btn, i) => {
    const type = btn.dataset.type;
    btn.addEventListener("click", function(e) {
      const id = btn.dataset.id;
      const readMoreContent = document.getElementById(
        `read-more-${type}-${id}`
      );
      readMoreContent.classList.add("hide");
      const readMoreButton = document.getElementById(
        `read-more-${type}-button-${id}`
      );
      readMoreButton.classList.remove("hide");
      btn.classList.add("hide");
    });
  });


  const openModalLink = document.querySelector('a#open-modal');
  if(openModalLink) {
    openModalLink.addEventListener('click', function(event) {
      event.preventDefault();
      var modal = document.querySelector('.modal');  // assuming you have only 1
      var html = document.querySelector('html');
      modal.classList.add('is-active');
      html.classList.add('is-clipped');

      modal.querySelector('.modal-close').addEventListener('click', function(e) {
        e.preventDefault();
        modal.classList.remove('is-active');
        html.classList.remove('is-clipped');
      });
    });
  }
});
