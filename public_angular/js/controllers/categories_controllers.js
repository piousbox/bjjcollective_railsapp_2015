'use strict';

var myApp = angular.module('myApp');

myApp.controller('CategoriesIndexController', ['$scope', '$state', 'Category',
                                      function( $scope,   $state,   Category) {
  Category.index({}, function(data) {
    $scope.categories = data.categories;
    $scope.category = {
      id:           data.id,
      title:        data.title,
      slug:         data.slug,
      short_slug:   data.short_slug
    };
  });
}]);
