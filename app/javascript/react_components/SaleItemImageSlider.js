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
        <img src={image.url}/>
      )
    })

    const thumbnailItemImages = this.state.itemImages.reduce((elements, image, i)=>{
      elements = elements || [];

      const lastColumns = elements[elements.length - 1];
      var insertIndex = 0;

      if(lastColumns){
        if(lastColumns.length < 4) {
          insertIndex = elements.length - 1;
        } else {
          insertIndex = elements.length;
          elements[insertIndex] = [];
        }
      } else {
        elements[0] = [];
      }

      const onClick = (e)=> {
        return this.slider.slickGoTo(e.target.getAttribute("data-image-index"));
      }

      elements[insertIndex].push(
        <div className="column is-3-mobile is-3-tablet is-3-desktop" data-image-index={i} onClick={ e => onClick(e)}>
          <img src={image.url} data-image-index={i} />
        </div>
      )

      return elements;
    }, [])

    const thumbnailColumns = ()=> {
      return thumbnailItemImages.map((columns, image)=>{
        return(
          <div className="columns is-mobile">
            {columns}
          </div>
        )
      });
    }

    return (
      <div className="container">
        <Slider ref={slider => (this.slider = slider)} {...settings}>
          {itemImages}
        </Slider>
        {thumbnailColumns()}
      </div>
    );
  }
}

export default SaleItemImageSlider;
