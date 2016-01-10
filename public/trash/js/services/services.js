'use strict';

// angular.module('myApp.services', []);
/* Services */

angular.module('myApp.services', [])
  .value('version', '0.0.1');

var myApp = angular.module('myApp');

/*
myApp.factory('City', ['$resource', 'Config', function($resource, Config) {
    var url = Config.api_endpoint + "/cities/:id.json";
    var defaults = {};
    var actions = { index: { method: 'GET', params: undefined, isArray: true, headers: undefined },
                    show:  { method: 'GET', isArray: false,
                             url: Config.api_endpoint + "/cities/:cityname.json"
                           }
                  };
    return $resource(url, defaults, actions);
}]);

myApp.factory('PathHelper', ['Config', function(Config) {
    return {
        city_path: function(city) {
            return "/cities/" + city.cityname;
        },
        city_report_path: function(city, report) {
            console.log(report, 'report is');
            return "/cities/" + city.cityname + "/reports/" + report.name_seo;
        }
    };
}]);
*/