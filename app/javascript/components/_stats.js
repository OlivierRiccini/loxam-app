function chartFunction(ctx, type, label, labels, datas) {
  var chart = new Chart(ctx, {
      // The type of chart we want to create
      type: type,

      // The data for our dataset
      data: {
          labels: labels,
          datasets: [{
              label: label,
              backgroundColor: ['rgb(225, 12, 34)',
                                'rgba(225, 12, 34, 0.8)',
                                'rgba(225, 12, 34, 0.6)',
                                'rgba(225, 12, 34, 0.4)',
                                'rgba(225, 12, 34, 0.2)'],
              borderColor: 'rgb(255, 255, 255)',
              data: datas,
          }]
      },

      // Configuration options go here
      options: {}
  });
};

var ctxCategories = document.getElementById('myChartCategories').getContext('2d');
var dataCategoriesName = $('#myChartCategories').data('category-name');
var dataNbSearchCategories = $('#myChartCategories').data('nb-searches');

var ctxProducts = document.getElementById('myChartProducts').getContext('2d');
var dataProductsName = $('#myChartProducts').data('product-name');
var dataNbSearches = $('#myChartProducts').data('nb-searches');

var ctxProductsSaved = document.getElementById('myChartSavedProducts').getContext('2d');
var dataProductsSavedName = $('#myChartSavedProducts').data('product-name');
var dataNbProductsSavedName = $('#myChartSavedProducts').data('nb-saved');

chartFunction(ctxCategories, 'doughnut', "Catégories les plus consultées", dataCategoriesName, dataNbSearchCategories);
chartFunction(ctxProducts, 'horizontalBar',"Matériels les plus consultées", dataProductsName, dataNbSearches);
chartFunction(ctxProductsSaved, 'horizontalBar', "Matériels les plus sauvegardés", dataProductsSavedName, dataNbProductsSavedName);
