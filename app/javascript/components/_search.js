const searchBar = document.getElementById('search-bar');
const searchList = document.getElementById('search-list');
var listSearchItems = document.querySelectorAll('#search-list li a');


var input;
function seach() {
  input = document.getElementById('search-bar').value.toUpperCase();

  // Accents insensitive
  if ( input.includes('É')) input = input.replace('É', 'E');
  if ( input.includes('È')) input = input.replace('È', 'E');

  // Allows search flexibility
  if ( input.includes('DIAMETRE')) input = input.replace('DIAMETRE', 'Ø');

  function modifMistakes(arrayOfMistakes, correction) {
    arrayOfMistakes.forEach(function(character) {
      if ( input.includes(character) ) input = input.replace(character, correction);
    });
  }

  const arrayOfMistakesPonceuse = [ 'PONSEUSE',
                                    'PONSEUSES',
                                    'PONCEUS',
                                    'PONSEUS',
                                    'PONSEUSES' ];

  modifMistakes(arrayOfMistakesPonceuse, 'PONCEUSE');

  listSearchItems.forEach(function(item) {
    if ( event.type === "click" ) {
      item.parentElement.classList.remove('result-search');
      searchList.style.display = 'none';
    } else if (item.text.toUpperCase().includes(input)) {
      item.parentElement.classList.add('result-search');
      searchList.style.display = 'block';
    } else {
      item.parentElement.classList.remove('result-search');
    }
  });
}

searchBar.addEventListener('keyup', seach);
document.addEventListener('click', seach);
