
angular.module('myApp.categories', ['ui.router']).
    config(['$stateProvider', '$urlRouterProvider', function(
             $stateProvider,   $urlRouterProvider) {

        $stateProvider.
            state('categories', {
                url: '/categories',
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
              url: '/categories/:c1_slug',
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
                         $scope.some_data = 'xxsome_dataxx';
                       }]
                }
              }
            });
    }]);
