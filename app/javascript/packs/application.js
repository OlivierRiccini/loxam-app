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

import 'components/_search';
import 'components/_dropdown-menu';
import 'components/_dropdown-categories';
import 'components/_scroll_to_top';
import '_product_page';

// $('.promo-card-image img').click(function() {
//   $(this).toggleClass('promo-card-image-img-active');
//   var top = ($(window).height() / 2) - ($(this).height() / 2);
//   var left = ($(window).width() / 2) - ($(this).width() / 2);
//   console.log($(this).height());
//   $(this).css({'top': top,
//                'left': left});
// });

$('#expand-cross').click(function() {
  $('.full-screen-promo').addClass('full-screen-promo-active');
});

$('#closing-cross').click(function() {
  $('.full-screen-promo').removeClass('full-screen-promo-active');
});
