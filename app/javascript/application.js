import Vue from "vue";
import App from "./components/App";
import Search from "./components/SearchField";

import React from "react";
import ReactDOM from "react-dom";
import Slider from "react-slick";

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

class SimpleSlider extends React.Component {
  render() {
    var settings = {
      dots: true,
      infinite: true,
      speed: 500,
      slidesToShow: 1,
      slidesToScroll: 1
    };
    return (
      <Slider {...settings}>
        <div>
          <h3>1</h3>
        </div>
        <div>
          <h3>2</h3>
        </div>
        <div>
          <h3>3</h3>
        </div>
        <div>
          <h3>4</h3>
        </div>
        <div>
          <h3>5</h3>
        </div>
        <div>
          <h3>6</h3>
        </div>
      </Slider>
    );
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<SimpleSlider />, document.getElementById("sale-item-image"));
});
