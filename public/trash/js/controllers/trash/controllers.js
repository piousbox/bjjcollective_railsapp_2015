'use strict';

angular.module('myApp.controllers', []);
var myApp = angular.module('myApp');
/* Controllers */

myApp.controller('MyCtrl1', [function() {
}]);

myApp.controller('MyCtrl2', [function() {
}]);

myApp.controller('CitiesIndexCtrl', ['$scope', 'City', 'PathHelper', function($scope, City, paths) {
    City.index({}, function(cities) {
        $scope.cities = cities;
        $scope.paths = paths;
    });
}]);

myApp.controller('CitiesShowCtrl', ["$scope", "$routeParams", 'City', 'PathHelper', function($scope, $routeParams, City, paths) {
    console.log('route params', $routeParams);
    City.show({ cityname: $routeParams.cityname }, function(data) {
        $scope.city = data;
        $scope.paths = paths;
    });
}]);
