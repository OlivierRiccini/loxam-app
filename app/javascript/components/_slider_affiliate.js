// $( document ).ready(function() {
  // $("#slider-affiliate-images > img:gt(0)").hide();
  // setInterval(function() {
  //   $('#slider-affiliate-images > img:first')
  //     .fadeOut(2000)
  //     .next()
  //     .fadeIn(3000)
  //     .end()
  //     .appendTo('#slider-affiliate-images');
  // }, 4000);
// }

// find affiliates container's height
const logoAffiliates = document.getElementById('affiliates-logo-navigation-container');

// Get slider
const slider = document.getElementById('slider-affiliate-images');

// Get slider images
const sliderImages = document.querySelectorAll('#slider-affiliate-images img');

console.log(slider);

// Set slider height
slider.style.height = `${logoAffiliates.offsetHeight}px`;


let i = 0;
let j = -1;

function changeImage() {
  jQuery(sliderImages[i++]).fadeIn(2000);
  jQuery(sliderImages[j++]).fadeOut(3000);
  if (i > sliderImages.length - 1) {
    i = 0;
  };
  if (j > sliderImages.length - 1) {
    j = 0;
  };
}

setInterval(changeImage, 3000);
