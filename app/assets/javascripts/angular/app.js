'use strict';

angular.module('myApp', [
  'ngRoute',
  'ngResource',
  'ngAnimate',
  'ui.router',
  'ngSanitize',
  'uiGmapgoogle-maps',
  'angulartics',
  'angulartics.google.analytics',

  'myApp.cities',
  'myApp.cities.service',

  'myApp.reports',
  'myApp.reports.service'

]).
run(['$rootScope', '$state', '$stateParams', function(
      $rootScope,   $state,   $stateParams) {
    $rootScope.$state = $state;
    $rootScope.$stateParams = $stateParams;
    }
  ]
).
config(['$routeProvider', '$locationProvider', '$stateProvider', '$urlRouterProvider', function(
         $routeProvider,   $locationProvider,   $stateProvider,   $urlRouterProvider) {

    $locationProvider.html5Mode(true);
    
    $stateProvider
        .state('home', {
            url: '/',
            templateUrl: "partials/welcome/home.html",
            resolve: {
                City: ['City', function(City) {
                    return City;
                }]
            },
            controller: ['$scope', '$state', 'City',
                function( $scope,   $state,   City) {
                    City.index({}, function(cities) {
                        $scope.cities = cities;
                        $scope.map = { center: { latitude: 42.1451, longitude: -100.6680 }, zoom: 4 }
                    });
                }]
            
        })
        .state('about', {
            url: '/about',
            template: "<h5>About template</h5>"
        });
    
}]).
constant('AUTH_EVENTS', {
  loginSuccess: 'auth-login-success',
  loginFailed: 'auth-login-failed',
  logoutSuccess: 'auth-logout-success',
  sessionTimeout: 'auth-session-timeout',
  notAuthenticated: 'auth-not-authenticated',
  notAuthorized: 'auth-not-authorized'
}).
constant('USER_ROLES', {
  all: '*',
  admin: 'admin',
  editor: 'editor',
  guest: 'guest'
}).
factory('AuthService', function ($http, Session) {
  var authService = {};
 
  authService.login = function (credentials) {
    return $http
      .post('http://api.local/en/users/sign_in', { user: credentials })
      .then(function (res) {
        Session.create(res.data.id, res.data.user.id,
                       res.data.user.role);
        return res.data.user;
      });
  };
 
  authService.isAuthenticated = function () {
    return !!Session.userId;
  };
 
  authService.isAuthorized = function (authorizedRoles) {
    if (!angular.isArray(authorizedRoles)) {
      authorizedRoles = [authorizedRoles];
    }
    return (authService.isAuthenticated() &&
      authorizedRoles.indexOf(Session.userRole) !== -1);
  };
 
  return authService;
}).
service('Session', function () {
  this.create = function (sessionId, userId, userRole) {
    this.id = sessionId;
    this.userId = userId;
    this.userRole = userRole;
  };
  this.destroy = function () {
    this.id = null;
    this.userId = null;
    this.userRole = null;
  };
}).
controller('LoginController', function ($scope, $rootScope, AUTH_EVENTS, AuthService) {
  $scope.credentials = {
    email: '',
    password: ''
  };
  $scope.login = function (credentials) {
    AuthService.login(credentials).then(function (user) {
      $rootScope.$broadcast(AUTH_EVENTS.loginSuccess);
      $scope.setCurrentUser(user);
    }, function () {
      $rootScope.$broadcast(AUTH_EVENTS.loginFailed);
    });
  };
});
