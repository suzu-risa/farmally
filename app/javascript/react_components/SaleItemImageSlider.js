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
        <img src={image.url} key={i}/>
      )
    });

    const thumbnailItemImageColumns = this.state.itemImages.map((image, i)=>{
      const onClick = (e)=> {
        return this.slider.slickGoTo(e.target.getAttribute("data-image-index"));
      }

      return (
        <div className="column is-3-mobile is-2-tablet is-2-desktop" data-image-index={i} onClick={ e => onClick(e)} key={i}>
          <img src={image.url} data-image-index={i} />
        </div>
      );
    });

    return (
      <div>
        <Slider ref={slider => (this.slider = slider)} {...settings}>
          {itemImages}
        </Slider>
        <div className="columns is-mobile is-multiline thumbnail-container">
          {thumbnailItemImageColumns}
        </div>
      </div>
    );
  }
}

export default SaleItemImageSlider;
