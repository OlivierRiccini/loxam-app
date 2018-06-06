const dashboardSections = document.querySelectorAll('.dashboard-section');
const tabs = document.querySelectorAll('.tab');

function displaySection(tab) {
  tab.classList.add('tab-active');
  dashboardSections.forEach(function(section) {
    if ( section.dataset.section === tab.dataset.section ) {
      section.classList.add('dashboard-section-active');
    } else {
      section.classList.remove('dashboard-section-active');
    }
  });
  tabs.forEach(function(otherTab) {
    if ( otherTab !== tab ) {
      otherTab.classList.remove('tab-active');
    }
  });
}

tabs.forEach(function(tab) {
  tab.addEventListener('click',
    function() {
      displaySection(tab);
  });
});


// / reload message section

// function reload() {
//   $('.container-messages').load(document.URL +  ' .container-messages');
// }

// setInterval(reload, 5000);

// function reloadNotif() {
//   $('.reload-notif').load(document.URL +  ' .reload-notif');
// }

// setInterval(reloadNotif, 5000);


// Add a product button
// const btnAddProduct = document.getElementById('add-product');

$('#add-product').click(function() {
  $('#form-product').slideToggle();
})

$('#add-promo').click(function() {
  $('#form-promo').slideToggle();
})
// edit product popup
const editIconsProducts = document.querySelectorAll('.edit-product-icon');
const editIconsPromos = document.querySelectorAll('.edit-promo-icon');
const closeCrosses = document.querySelectorAll('.close-popup');

function showPopupEditItem(item, item_id) {
  var popUp = document.getElementById(`pop-up-edit-${item}-${item_id}`);
  popUp.classList.add(`pop-up-${item}-active`);

  function closePopup() {
   popUp.classList.remove(`pop-up-${item}-active`);
  };
  closeCrosses.forEach(function(closeCrosse) {
    closeCrosse.addEventListener('click', closePopup);
  });
}

editIconsProducts.forEach(function(editIcon) {
  editIcon.addEventListener('click',
    function() {
      showPopupEditItem('product', editIcon.dataset.productId);
  });
});

editIconsPromos.forEach(function(editIcon) {
  editIcon.addEventListener('click',
    function() {
      showPopupEditItem('promo', editIcon.dataset.promoId);
  });
});

