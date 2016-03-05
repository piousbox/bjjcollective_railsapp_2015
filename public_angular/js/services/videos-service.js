'use strict';

angular.module('myApp.videos.service', []).
    factory('Video', ['$resource', 'Config', function($resource, Config) {
      
        console.log('service Video');
      
        var url = Config.api_endpoint + "/videos/in/:category_id/page/:videos_page.json";
        var defaults = {};
        var actions = { 
                        index:    { method: 'GET', url: "" },
                        index_in: { method: 'GET', url: "" }
                      };
        return $resource(url, defaults, actions);
    }]);
