import React from "react";
import Slider from "react-slick";
import axios from "axios";

class SaleItemImageSlider extends React.Component {
  constructor() {
    super();
    this.state = {
      itemImages: new Array,
    };
  }

  componentWillMount (){
    axios.get(this.props.url)
    .then((res) => {
      this.setState({ itemImages: res.data.sale_item_images })
    })
    .catch(console.error);
  }

  render() {
    const settings = {
      dots: true,
      infinite: true,
      speed: 500,
      slidesToShow: 1,
      slidesToScroll: 1
    };

    const itemImages = this.state.itemImages.map((image, i)=>{
      return (
        <img src={image.url} />
      )
    })
    return (
      <Slider {...settings}>
        {itemImages}
      </Slider>
    );
  }
}

export default SaleItemImageSlider;
