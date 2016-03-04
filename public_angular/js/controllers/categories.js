'use strict';

angular.module('myApp.categories', ['ui.router']).
    config(['$stateProvider', '$urlRouterProvider', '$urlMatcherFactoryProvider', function(
             $stateProvider,   $urlRouterProvider,   $urlMatcherFactoryProvider ) {

        function valToString(val) {
            if (undefined === val) { val = null }
            return val !== null ? val.toString() : val;
        }         
        $urlMatcherFactoryProvider.type('nonURIEncoded', {
            encode: valToString,
            decode: valToString,
            is: function () { return true; }
        });
                 
        $stateProvider.
            state('categories', {
                url: '/{path:nonURIEncoded}',
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
            state('category', {
                url: '/category/:id',
                views: {
                    '': {
                        templateUrl: '/partials/categories/categories.html',
                        resolve: {
                            Category: ['Category', function(Category) {
                                 return Category;
                            }]
                        },
                        controller: 'CategoriesIndexSimpleExpandedController' 
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
                             short_slug: data.short_slug,
                             path: data.path
                           }
                         });
                       }]
                }
              }
            });
    }]);
