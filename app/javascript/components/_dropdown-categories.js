$('#toggle-categories-arrow').click(function() {
  const close = '<i class="fa fa-arrow-left"></i> Fermer';
  const categories = 'Categories <i class="fa fa-arrow-right"></i>';
  if ( $('#toggle-categories-arrow span').html() == categories ) {
    $('#toggle-categories-arrow span').html(close);
     $('.tags-catgories-container-small-screen').animate({ width: 'show' });
  } else {
     $('#toggle-categories-arrow span').html(categories);
     $('.tags-catgories-container-small-screen').animate({ width: 'hide' });
  }
});


$('.category-tag').click(function() {
  $(this).toggleClass('tag-actif');
});
