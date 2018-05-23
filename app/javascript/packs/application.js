/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// app/assets/javascripts/application.js

//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

console.log('Hello World from Webpacker');

$('.dropdown-toggle').click(function() {
  $('.dropdown-menu').toggle('.dropdown-menu');
});

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
