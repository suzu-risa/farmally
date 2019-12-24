import React from "react";
import Slider from "react-slick";
import axios from "axios";

function NextArrow(props) {
  const { className, style, onClick } = props;
  return (
    <div
      className="sale-items__item__image-area__container__main-image__slider-arrow next"
      onClick={onClick}
    >
      <NextArrowSvg />
    </div>
  );
}

function PrevArrowSvg(props) {
  return (
    <svg 
      xmlns="http://www.w3.org/2000/svg"
      xmlnsXlink="http://www.w3.org/1999/xlink"
      viewBox="0 0 36 36"
    >
        <defs>
            <style> {`
                .arrow-for-image-list-prev__guide__circle {
                    opacity: 0.1;
                    fill: url(#arrow-for-image-list-prev__gradient);
                }
                .arrow-for-image-list-prev__guide__border {
                    fill: #f2f2f1;
                }
                .arrow-for-image-list-prev__guide__polyline {
                    fill: none;
                    stroke: #4c443d;
                    stroke-linecap: round;
                    stroke-linejoin: round;
                    stroke-width: 1.5px;
                }
            `} </style>
            <linearGradient
              id="arrow-for-image-list-prev__gradient"
              x1="16.5"
              y1="40"
              x2="51.5"
              y2="40"
              gradientTransform="translate(58 -16) rotate(90)"
              gradientUnits="userSpaceOnUse"
            >
                <stop
                  offset="0.6"
                  stop-color="#4c443d"
                  stop-opacity="0"
                />
                <stop
                  offset="1"
                  stop-color="#4c443d"
                />
            </linearGradient>
        </defs>
        <title>arrow-for-image-list-prev</title>
        <g id="arrow-for-image-list-prev" data-name="arrow-for-image-list-prev">
            <g id="arrow-for-image-list-prev__guide">
                <circle
                  class="arrow-for-image-list-prev__guide__circle"
                  cx="18"
                  cy="18"
                  r="17.5"
                />
                <path
                  class="arrow-for-image-list-prev__guide__border"
                  d="M18,1A17,17,0,1,1,1,18,17,17,0,0,1,18,1m0-1A18,18,0,1,0,36,18,18.05,18.05,0,0,0,18,0Z"
                />
                <polyline
                  class="arrow-for-image-list-prev__guide__polyline"
                  points="19.76 12 14.24 17.5 19.76 23"
                />
            </g>
        </g>
    </svg>
  );
}

function NextArrowSvg(props) {
  return(
    <svg
      xmlns="http://www.w3.org/2000/svg"
      xmlnsXlink="http://www.w3.org/1999/xlink"
      viewBox="0 0 36 36"
    >
        <defs>
            <style> {`
                .arrow-for-image-list-next__guide__circle {
                    opacity: 0.1;
                    fill: url(#arrow-for-image-list-next__gradient);
                }
                .arrow-for-image-list-next__guide__path {
                    fill: #f2f2f1;
                }
                .arrow-for-image-list-next__guide__polyline {
                    fill: none;
                    stroke: #4c443d;
                    stroke-linecap: round;
                    stroke-linejoin: round;
                    stroke-width: 1.5px;
                }
            `}</style>
            <linearGradient
              id="arrow-for-image-list-next__gradient"
              x1="0.5"
              y1="18"
              x2="35.5"
              y2="18"
              gradientTransform="translate(36) rotate(90)"
              gradientUnits="userSpaceOnUse"
            >
              <stop
                offset="0.6"
                stop-color="#4c443d"
                stop-opacity="0"
              />
              <stop
                offset="1"
                stop-color="#4c443d"
              />
            </linearGradient>
        </defs>
        <title>arrow-for-image-list-next</title>
        <g id="arrow-for-image-list-next" data-name="arrow-for-image-list-next">
            <g id="arrow-for-image-list-next__guide">
                <circle
                  class="arrow-for-image-list-next__guide__circle"
                  cx="18"
                  cy="18"
                  r="17.5"
                />
                <path
                  class="arrow-for-image-list-next__guide__path"
                  d="M18,1A17,17,0,1,1,1,18,17,17,0,0,1,18,1m0-1A18,18,0,1,0,36,18,18.05,18.05,0,0,0,18,0Z"
                 />
                <polyline
                  class="arrow-for-image-list-next__guide__polyline"
                  points="16.24 24 21.76 18.5 16.24 13"
                />
            </g>
        </g>
    </svg>
  );
}

function PrevArrow(props) {
  const { className, style, onClick } = props;
  return (
    <div
      className="sale-items__item__image-area__container__main-image__slider-arrow prev"
      onClick={onClick}
    >
      <PrevArrowSvg />
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
      nextArrow: <NextArrow />,
      prevArrow: <PrevArrow />,
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
