'use strict';

angular.module('myApp.reports.service', [])
.factory('Report', ['$resource', 'Config', function($resource, Config) {
    var url = Config.api_endpoint + "/reports.json";
    var defaults = {};
    var actions = { index: { method: 'GET', params: undefined, isArray: true, headers: undefined },
                    show:  { method: 'GET', isArray: false,
                             url: Config.api_endpoint + "/reports/:name_seo.json"
                           }
                  };
    return $resource(url, defaults, actions);
}]);