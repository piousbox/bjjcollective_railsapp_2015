'use strict';

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
                        // controller: 'CategoriesIndexController' 
                        controller: ['$scope', '$state', 'Category',
                            function( $scope,   $state,   Category) {
                              Category.index({}, function(categories) {
                                $scope.categories = categories;
                              });
                            }]
                    }
                }
            }).
            state('categories_1', {
              url: '/:slug',
              views: {
                '': {
                  templateUrl: '/partials/categories/categories_1.html',
                  resolve: {
                    Category: ['Category', function(Category) {
                      return Category;
                    }]
                  },
                  controller: ['$scope', '$stateParams', 'Category',
                       function($scope,   $stateParams,  Category) {
                         Category.index({ slug: $stateParams.slug }, function(categories) {
                           $scope.categories = categories;
                         });
                       }]
                }
              }
            }).
            state('categories_1.detail', {
              url: '/:slug_detail',
              parent: 'categories_1',
              views: {
                'detail': {
                  templateUrl: '/partials/categories/categories_2.html',
                  resolve: {
                    Category: ['Category', function(Category) {
                      return Category;
                    }]
                  },
                  controller: ['$scope', '$stateParams', 'Category',
                       function($scope,   $stateParams,  Category) {
                       }]
                }
              }
            });
    }]);
