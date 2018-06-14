$(document).ready(function(){
  //Check to see if the window is top if not then display button
  $(window).scroll(function(){
    if ($(this).scrollTop() > 400) {
      $('#scrollToTop').fadeIn();
    } else {
      $('#scrollToTop').fadeOut();
    }
    // if ($('#scrollToTop').offset().top > 2620 &&
    //   $('#scrollToTop').offset().top < 2620)
    var arrow_position = $('#scrollToTop').offset().top;
    var footer_position = $('.footer').offset().top;
    if ( arrow_position < footer_position || arrow_position >= (footer_position + 204)) {
      $('#scrollToTop').css('color', 'rgb(225, 12, 34)',
        'background-color', '#fff');
    } else if (arrow_position >= footer_position && arrow_position <= (footer_position + 204) ) {
      $('#scrollToTop').css('color', '#fff',
        'background-color', 'rgb(225, 12, 34)');
    }
  });
  //Click event to scroll to top
  $('#scrollToTop').click(function(){
    $('html, body').animate({scrollTop : 0},800);
    return false;
  });

});


