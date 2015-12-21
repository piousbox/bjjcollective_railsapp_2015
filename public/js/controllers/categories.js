
angular.module('myApp.categories', ['ui.router']).
    config(['$stateProvider', '$urlRouterProvider', function(
             $stateProvider,   $urlRouterProvider) {

        $stateProvider.
            state('categories', {
                url: '/',
                views: {
                    '': {
                        templateUrl: '/partials/categories/categories.html',
                        resolve: {
                            Category: ['Category', function(Category) {
                                return Category;
                            }]
                        },
                        controller: 'CategoriesIndexController' 
                    }
                }
            }).
            state('categories.c1', {
              url: '/:c0_slug/:c1_slug',
              parent: 'categories',
              views: {
                '': {
                  templateUrl: '/partials/categories/categories_c1.html',
                  resolve: {
                    Category: ['Category', function(Category) {
                      return Category;
                    }]
                  },
                  controller: ['$scope', '$stateParms', 'Category',
                       function($scope,   $stateParams,  Category) {
                         $scope.some_data = 'xxsome_data';
                       }]
                }
              }
            });
    }]);
