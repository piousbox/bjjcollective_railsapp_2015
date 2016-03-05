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

myApp.controller('CategoriesIndexSimpleExpandedController', ['$scope', '$location', '$anchorScroll', '$state', '$stateParams', 'Category',
                                                    function( $scope,   $location,   $anchorScroll,   $state,   $stateParams,   Category) {
  Category.show_simple_expanded({ id: $stateParams.id }, function(data) {
    $scope.categories = data.categories;
    $scope.selectedId = $stateParams.id
    $scope.category = {
      id:           data.id,
      title:        data.title,
      slug:         data.slug,
      short_slug:   data.short_slug,
      path:         data.path
    };
  });
}]);

myApp.controller('LegacyCategoryDetailController', ['$scope', '$location', '$anchorScroll', '$state', '$stateParams', 'Category',
                                           function( $scope,   $location,   $anchorScroll,   $state,   $stateParams,   Category) {
  Category.show_simple_expanded({ id: $stateParams.detail_id }, function(data) {
    $scope.categories = data.categories;
  });
}]);

myApp.controller('LegacyCategoryVideosController', ['$scope', '$location', '$state', '$stateParams', 'Category', 'Video',
                                           function( $scope,   $location,   $state,   $stateParams,   Category,   Video) {
  Video.index_in({ category_id: $stateParams.videos_id }, function(data) {
    $scope.videos   = data.videos;
    $scope.category = data.category;
    $scope.n_videos = data.n_videos;
  });
}]);


