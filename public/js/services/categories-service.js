'use strict';

angular.module('myApp.categories.service', []).
    factory('Category', ['$resource', 'Config', function($resource, Config) {
        var url = Config.api_endpoint + "/categories/:id.json";
        var defaults = {};
        var actions = { index: { method: 'GET', params: undefined, isArray: true, headers: undefined },
                        show:  { method: 'GET', isArray: false,
                                 url: Config.api_endpoint + "/category/:slug.json"
                               }
                      };
        return $resource(url, defaults, actions);
    }]);
