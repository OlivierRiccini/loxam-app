let colImage = document.querySelector('.image-col');
let colInfos = document.querySelector('.row-presentation-product .col-xs-12:nth-child(2)');

if (colImage) {
  colImage.style.height = `${colInfos.offsetHeight}px`;
}
