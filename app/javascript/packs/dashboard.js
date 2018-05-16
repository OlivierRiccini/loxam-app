// const categoriesSection = document.querySelector('.dashboard-categories-section');
// const productsSection = document.querySelector('.dashboard-products-section');
// const promosSection = document.querySelector('.dashboard-promos-section');
// const usersSection = document.querySelector('.dashboard-users-section');
// const documentsSection = document.querySelector('.dashboard-documents-section');
// const statsSection = document.querySelector('.dashboard-stats-section');
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
})
