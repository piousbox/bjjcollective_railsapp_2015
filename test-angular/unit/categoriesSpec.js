'use strict';

describe('categories', function() {
  beforeEach(module('myApp.categories'));
  beforeEach(module('myApp'));
	
  var $controller, $q, $rootScope, $scope;

  beforeEach(inject(function(_$controller_, _$q_, _$rootScope_) {
    $controller = _$controller_;
    $q = _$q_;
    $rootScope = _$rootScope_;
    $scope = $rootScope.$new();
  }));

  describe('CategoriesIndexController', function() {
    it('does', function() {

      var category = function (properties){
        for(var k in properties) 
          this[k]=properties[k];
      };
      category.index = function(params, success, error){
        return success({ 
          some: 'value', 
          categories: [1, 2, 'categories'], 
          category: { some: 'category' },
          id: 'id',
          title: 'title',
          slug: 'slug',
          short_slug: 'short_slug'
        });
        /* var deferred = $q.defer();
        deferred.resolve( {id: 1, ans:'wer'} );
        return deferred.promise; */
      };

      var this_controller = $controller('CategoriesIndexController', { $scope: $scope, $state: {}, Category: category } );
      expect($scope.sanity).toEqual('I am sane.');
      expect($scope.categories).toEqual([1, 2, 'categories']);
      expect($scope.category.id).toEqual('id');
      expect($scope.category.title).toEqual('title');
      expect($scope.category.slug).toEqual('slug');
      expect($scope.category.short_slug).toEqual('short_slug');
    });
  });

});
