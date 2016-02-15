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
                        controller: 'CategoriesIndexController' 
                    }
                }
            }).
            state('categories.categories', {
              url: '/:short_slug', /* /categories is prepended */
              views: {
                'subcategory': {
                  templateUrl: '/partials/categories/categories.html',
                  resolve: {
                    Category: ['Category', function(Category) {
                      return Category;
                    }]
                  },
                  controller: ['$scope', '$stateParams', 'Category',
                       function($scope,   $stateParams,   Category) {
                         Category.show({ short_slug: $stateParams.short_slug }, function(data) {
                           $scope.category = {
                             id: data.id,
                             title: data.title,
                             slug: data.slug,
                             short_slug: data.short_slug
                           }
                         });
                       }]
                }
              }
            });
    }]);
