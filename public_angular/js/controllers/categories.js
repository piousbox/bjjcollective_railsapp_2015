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
            state('legacy-category', {
                url: '/legacy-category',
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
            state('legacy-category-2', {
                url: '/legacy-category/:id',
                views: {
                    '': {
                        templateUrl: '/partials/categories/categories_2.html',
                        controller: 'LegacyCategoryDetailController'
                    }
                }
            }).
            state('legacy-category-2.detail', {
                url: '/detail/:detail_id',
                views: {
                    '': {
                        templateUrl: '/partials/categories/categories_2.html',
                        controller: 'LegacyCategoryDetailController'
                    }
                }
            }).
            state('legacy-category.detail.videos', {
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
            }).
            state('categories', {
                url: '/categories-by-path/{path:nonURIEncoded}',
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
            });
    }]);
