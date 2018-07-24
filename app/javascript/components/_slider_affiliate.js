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

const images = document.querySelectorAll('#slider-affiliate-images img');

let i = 0;
let j = -1;

function slider() {
  jQuery(images[i++]).fadeIn(2000);
  jQuery(images[j++]).fadeOut(3000);
  if (i > images.length - 1) {
    i = 0;
  };
  if (j > images.length - 1) {
    j = 0;
  };
}

setInterval(slider, 3000);
