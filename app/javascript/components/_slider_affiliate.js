$("#slider-affiliate-images > img:gt(0)").hide();

setInterval(function() {
  $('#slider-affiliate-images > img:first')
    .fadeOut(2000)
    .next()
    .fadeIn(3000)
    .end()
    .appendTo('#slider-affiliate-images');
},  4000);
