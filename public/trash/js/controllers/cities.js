
angular.module('myApp.cities', ['ui.router']).
    config(['$stateProvider', '$urlRouterProvider', function(
             $stateProvider,   $urlRouterProvider) {

        $stateProvider.
            state('cities', {
                url: '/cities',
                views: {
                    '': {
                        templateUrl: '/partials/cities/cities.html',
                        resolve: {
                            City: ['City', function(City) {
                                return City;
                            }]
                        },
                        controller: 'CitiesIndexController' /* ['$scope', '$state', 'City',
                                     function( $scope,   $state,   City) {
                                         City.index({}, function(cities) {
                                             $scope.cities = cities;
                                         });
                                     }] */
                    }
                }
            }).
            state('cities.city', {
                url: '/travel-to/:cityname',
                parent: 'cities',
                views: {
                    '': {
                        templateUrl: '/partials/cities/city.html',
                        resolve: {
                            City: ['City', function(City) {
                                return City;
                            }]
                        },
                        controller: ['$scope', '$stateParams', 'City', function($scope, $stateParams, City) {
                            City.show({ cityname: $stateParams.cityname }, function(city) {
                                $scope.city = city;
                                $scope.map = { center: { latitude: city.x, longitude: city.y }, zoom: 8 };
                            });
                        }]
                    }
                }
            }).
            state('cities.report', {
                url: '/reports/show/:name_seo',
                parent: 'cities.city',
                views: {
                    '': {
                        templateUrl: '/partials/reports/show.html',
                        resolve: {
                            Report: ['Report', function(Report) {
                                return Report;
                            }]
                        },
                        controller: ['$scope', '$stateParams', 'Report', function($scope, $stateParams, Report) {
                            Report.show({ name_seo: $stateParams.name_seo }, function(data) {
                                $scope.report = data;
                            });
                        }]
                    }
                }
            });
    }]).
    controller('CitiesIndexController',
               [ '$scope', '$state', 'City',
        function( $scope,   $state,   City) {
            City.index({}, function(cities) {
                $scope.cities = cities;
            });
        }]
    );
