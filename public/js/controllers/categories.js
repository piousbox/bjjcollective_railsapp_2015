
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
            });
    }]);
