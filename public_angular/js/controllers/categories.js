
angular.module('myApp.categories', ['ui.router']).
    config(['$stateProvider', '$urlRouterProvider', function(
             $stateProvider,   $urlRouterProvider) {

        $stateProvider.
            state('categories', {
                url: '/technique',
                views: {
                    '': {
                        templateUrl: '/partials/categories/categories.html',
                        resolve: {
                            Category: ['Category', function(Category) {
                                return Category;
                            }]
                        },
                        // controller: 'CategoriesIndexController' 
                        controller: ['$scope', '$state', 'Category',
                            function( $scope,   $state,   Category) {
                              Category.index({}, function(categories) {
                                console.log("categories are", categories);
                                $scope.categories = categories;
                              });
                            }]
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
