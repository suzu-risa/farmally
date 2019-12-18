import React from "react";
import Slider from "react-slick";
import axios from "axios";

function SampleNextArrow(props) {
  const { className, style, onClick } = props;
  return (
    <div
      className="sale-items__item__image-area__container__main-image__slider-arrow next"
      onClick={onClick}
    >
      <img
        src="/images/arrow-next.svg"
      />
    </div>
  );
}

function SamplePrevArrow(props) {
  const { className, style, onClick } = props;
  return (
    <div
      className="sale-items__item__image-area__container__main-image__slider-arrow prev"
      onClick={onClick}
    >
      <img
        src="/images/arrow-prev.svg"
      />
    </div>
  );
}

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
    const main_slider_settings = {
      dots: false,
      infinite: true,
      speed: 500,
      slidesToShow: 1,
      slidesToScroll: 1,
      nextArrow: <SampleNextArrow />,
      prevArrow: <SamplePrevArrow />,
      beforeChange: (oldIndex, newIndex) => {
      },
      afterChange: ()=> {
        if(typeof gtag == "function"){
          gtag('event', '商品画像切り替え', { 'event_category': '出品商品' });
        }
      }
    };

    const itemImages = this.state.itemImages.map((image, i)=>{
      return (
        <img src={image.url} key={i} alt={image.alt + ' 商品写真 ' + (i+1)}/>
      )
    });

    const thumbnailItemImageColumns = this.state.itemImages.map((image, i)=>{
      const onClick = (e)=> {
        return this.slider.slickGoTo(e.target.getAttribute("data-image-index"));
      }

      return (
        <div 
          className= 'sale-items__item__image-area__container__thumbnails__item'
          data-image-index={i}
          onClick={ e => onClick(e)}
          key={i}
        >
          <img src={image.url} data-image-index={i} alt={image.alt + ' 商品写真サムネイル ' + (i+1)} />
        </div>
      );
    });

    return (
      <div>
        <Slider ref={slider => (this.slider = slider)} {...main_slider_settings} className="sale-items__item__image-area__container__main-image">
          {itemImages}
        </Slider>
        <div className="sale-items__item__image-area__container__thumbnails">
          {thumbnailItemImageColumns}
        </div>
      </div>
    );
  }
}

export default SaleItemImageSlider;
