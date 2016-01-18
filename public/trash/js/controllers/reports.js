
angular.module('myApp.reports', ['ui.router']).
    config(['$stateProvider', '$urlRouterProvider', function(
             $stateProvider,   $urlRouterProvider) {

        $stateProvider.
            state('reports', {
                url: '/reports',
                views: {
                    '': {
                        templateUrl: '/partials/reports/list.html',
                        resolve: {
                            Report: ['Report', function(Report) {
                                return Report;
                            }]
                        },
                        controller: ['$scope', 'Report', '$stateParams', function($scope, Report, $stateParams) {
                            Report.index({}, function(data) {
                                $scope.reports = data;
                            });
                        }]
                    }
                }
            });
    }]);