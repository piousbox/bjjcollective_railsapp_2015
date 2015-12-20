'use strict';

angular.module('myApp.cities.service', []).
    factory('City', ['$resource', 'Config', function($resource, Config) {
        var url = Config.api_endpoint + "/cities/:id.json";
        var defaults = {};
        var actions = { index: { method: 'GET', params: undefined, isArray: true, headers: undefined },
                        show:  { method: 'GET', isArray: false,
                                 url: Config.api_endpoint + "/cities/:cityname.json"
                               }
                      };
        return $resource(url, defaults, actions);
    }]);