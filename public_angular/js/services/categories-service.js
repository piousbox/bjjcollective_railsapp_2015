'use strict';

angular.module('myApp.categories.service', []).
    factory('Category', ['$resource', 'Config', function($resource, Config) {
      
        var url = Config.api_endpoint + "/categories/:slug/:slug_detail.json";
        var defaults = {};
        var actions = { index:   { method: 'GET', params: undefined, isArray: false, headers: undefined },
                        show:    { method: 'GET', isArray: false,
                                   url: Config.api_endpoint + "/category/:slug.json"
                                 },
                        index_1: { method: 'GET', 
                                   url: Config.api_endpoint + "/categories/:slug/:slug_0/:slug_1.json" 
                                 },
                        index_2: { method: 'GET',
                                   url: Config.api_endpoint + "/categories/:slug/:slug_0/:slug_1/:slug_2/:slug_3.json"
                                 }
                      };
        return $resource(url, defaults, actions);
    }]);
