'use strict';

angular.module('myApp', [
  'ngRoute',
  'ngResource',
  'ngAnimate',
  'ui.router',
  'ngSanitize',
  'angulartics',
  'angulartics.google.analytics',

  'myApp.categories',
  'myApp.categories.service'

]).
run(['$rootScope', '$state', '$stateParams', '$anchorScroll', function(
      $rootScope,   $state,   $stateParams,   $anchorScroll) {
    $rootScope.$state = $state;
    $rootScope.$stateParams = $stateParams;
}]).
config(['$routeProvider', '$locationProvider', '$stateProvider', '$urlRouterProvider', function(
         $routeProvider,   $locationProvider,   $stateProvider,   $urlRouterProvider) {

    var base_url = "";
    $locationProvider.html5Mode(true);
    
    $stateProvider.
        state('home', {
            url: base_url+"/home",
            templateUrl: "/partials/welcome/home.html",
            resolve: {
                Category: ['Category', function(Category) {
                    return Category;
                }]
            },
            controller: ['$scope', '$state', 'Category',
                function( $scope,   $state,   Category) {
                  Category.index({}, function(categories) {
                    $scope.categories = categories;
                  });
                }]
            
        }).
        state('about', {
            url: base_url+'/about',
            template: "<h5>About template</h5>"
        });
    
}]);
