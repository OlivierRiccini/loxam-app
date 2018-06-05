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
function reload() {
  $('.container-messages').load(document.URL +  ' .container-messages');
}

setInterval(reload, 5000);

function reloadNotif() {
  $('.reload-notif').load(document.URL +  ' .reload-notif');
}

setInterval(reloadNotif, 5000);


// Add a product button
const btnAddProduct = document.getElementById('add-product');

$('#add-product').click(function() {
  $('.row-product-form').slideToggle();
})

// edit product popup
const editIcons = document.querySelectorAll('.edit-product-icon');
const closeCrosses = document.querySelectorAll('.close-popup');

function showPopupEditProduct(product_id) {
  var popUp = document.getElementById(`pop-up-edit-product-${product_id}`);
  popUp.classList.add('pop-up-product-active');

  function closePopup() {
   popUp.classList.remove('pop-up-product-active');
  };
  closeCrosses.forEach(function(closeCrosse) {
    closeCrosse.addEventListener('click', closePopup);
  });
}

editIcons.forEach(function(editIcon) {
  editIcon.addEventListener('click',
    function() {
      showPopupEditProduct(editIcon.dataset.productId);
  });
});


