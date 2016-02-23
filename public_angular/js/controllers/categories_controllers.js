'use strict';

var myApp = angular.module('myApp');

myApp.controller('CategoriesIndexController', ['$scope', '$location', '$anchorScroll', '$state', '$stateParams', 'Category',
                                      function( $scope,   $location,   $anchorScroll,   $state,   $stateParams,   Category) {

  Category.index_by_path({ path: $stateParams.path }, function(data) {
    $scope.categories = data.categories;
    $scope.category = {
      id:           data.id,
      title:        data.title,
      slug:         data.slug,
      short_slug:   data.short_slug,
      path:         data.path
    };
    $location.hash(data.id);
    setTimeout(function() {
      $anchorScroll();
    }, 50);
  });
}]);
