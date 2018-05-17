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


/// reload message section
function reload() {
  $('.container-messages').load(document.URL +  ' .container-messages');
}

setInterval(reload, 2000);

function reloadNotif() {
  $('.reload-notif').load(document.URL +  ' .reload-notif');
}

setInterval(reloadNotif, 2000);
