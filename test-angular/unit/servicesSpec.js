'use strict';

describe('service', function() {
  beforeEach(module('myApp.services'));

  var $controller;

  beforeEach(inject(function(_$controller_) {
    $controller = _$controller_;
  }));

  describe('something', function() {
    it('does', function() {
      expect(true).toEqual(true);
    });
  });

  describe('version', function() {
    it('should return current version', inject(function(version) {
      expect(version).toEqual('0.0.1');
    }));
  });

});
