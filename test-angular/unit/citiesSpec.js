'use strict';

describe('cities', function() {
  beforeEach(module('myApp.cities'));
	
  var $controller, $q, $rootScope, $scope;

  beforeEach(inject(function(_$controller_, _$q_, _$rootScope_) {
    $controller = _$controller_;
    $q = _$q_;
    $rootScope = _$rootScope_;
    $scope = $rootScope.$new();
  }));

  describe('CitiesIndexController', function() {
    it('does', function() {

      var city = function (properties){
        for(var k in properties) 
          this[k]=properties[k];
      };
      city.index = function(params, success, error){
        return success({ some: 'value' });
        /* var deferred = $q.defer();
        deferred.resolve( {id: 1, ans:'wer'} );
        return deferred.promise; */
      };

      var this_controller = $controller('CitiesIndexController', { $scope: $scope, $state: {}, City: city } );
      expect($scope.cities).toEqual({ some: 'value' });
    });
  });

});
