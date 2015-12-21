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
                              Category.index({}, function(data) {
                                $scope.categories = data.categories;
                                $scope.category = {
                                  id:           data.id,
                                  title:        data.title,
                                  slug:         data.slug,
                                  short_slug:   data.short_slug
                                };
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
                         Category.index({ slug: $stateParams.slug, slug_detail: $stateParams.slug_detail }, function(data) {
                           $scope.categories = data.categories;
                           $scope.category = {
                             id:           data.id,
                             title:        data.title,
                             slug:         data.slug,
                             short_slug:   data.short_slug
                          };
                         });
                       }]
                }
              }
            }).
            state('categories_1.detail', {
              url: '/:slug_0/:slug_1', // "/:slug" is prepended from parent.
              parent: 'categories_1',
              views: {
                'detail': {
                  templateUrl: '/partials/categories/categories_1_detail.html',
                  resolve: {
                    Category: ['Category', function(Category) {
                      return Category;
                    }]
                  },
                  controller: ['$scope', '$stateParams', 'Category',
                       function($scope,   $stateParams,  Category) {
                         Category.index_1({ slug: $stateParams.slug, slug_0: $stateParams.slug_0, slug_1: $stateParams.slug_1 }, function(data) {
                           $scope.categories = data.categories;
                           $scope.category = {
                             id:           data.id,
                             title:        data.title,
                             slug:         data.slug,
                             short_slug:   data.short_slug
                          };
                         });
                       }]
                }
              }
            }).
            state('categories_1.detail.videos', {
              url: '/:slug_2/:slug_3/videos', // "/:slug/:slug_0/:slug_1" is prepended from parent.
              parent: 'categories_1.detail',
              views: {
                'videos': {
                  templateUrl: '/partials/videos/videos.html',
                  resolve: {
                    Category: ['Category', function(Category) {
                      return Category;
                    }]
                  },
                  controller: ['$scope', '$stateParams', 'Category',
                       function($scope,   $stateParams,  Category    ) {
                         var i, n_pages=[];
                         
                         Category.index_2({ slug: $stateParams.slug, slug_0: $stateParams.slug_0, slug_1: $stateParams.slug_1,
                                            slug_2: $stateParams.slug_2, slug_3: $stateParams.slug_3
                                          }, function(data) {
                           $scope.category = {
                             id:           data.id,
                             title:        data.title,
                             slug:         data.slug,
                             short_slug:   data.short_slug
                           };
                           $scope.videos   = data.videos;
                           for (i=1; i<=data.n_pages; i++) {
                             n_pages.push( i );
                           }
                           $scope.n_pages  = n_pages;
                         });
                       }]
                }
              }
            }).
            state('categories_1.detail.videos_paged', {
              url: '/:slug_2/:slug_3/videos/page/:videos_page', // "/:slug/:slug_0/:slug_1" is prepended from parent.
              parent: 'categories_1.detail',
              views: {
                'videos': {
                  templateUrl: '/partials/videos/videos.html',
                  resolve: {
                    Category: ['Category', function(Category) {
                      return Category;
                    }]
                  },
                  controller: ['$scope', '$stateParams', 'Category',
                       function($scope,   $stateParams,  Category    ) {
                         var i, n_pages=[];
                         
                         Category.index_2({ slug: $stateParams.slug, slug_0: $stateParams.slug_0, slug_1: $stateParams.slug_1,
                                            slug_2: $stateParams.slug_2, slug_3: $stateParams.slug_3, videos_page: $stateParams.videos_page
                                          }, function(data) {
                           $scope.category = {
                             id:           data.id,
                             title:        data.title,
                             slug:         data.slug,
                             short_slug:   data.short_slug
                           };
                           $scope.videos   = data.videos;
                           for (i=1; i<=data.n_pages; i++) {
                             n_pages.push( i );
                           }
                           $scope.n_pages  = n_pages;
                           $scope.n_videos = data.n_videos;
                         });
                       }]
                }
              }
            });
    }]);
