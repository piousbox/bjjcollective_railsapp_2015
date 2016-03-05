'use strict';

angular.module('myApp.videos.service', []).
    factory('Video', ['$resource', 'Config', function($resource, Config) {
        var url = Config.api_endpoint + "/videos/in/:category_id/page/:videos_page.json";
        var defaults = {};
        var actions = { 
                        index:    { method: 'GET', url: "" },
                        index_in: { method: 'GET', url: "" },
                        show:     { method: 'GET', url: Config.api_endpoint + "/video/:video_id.json" }
                      };
        return $resource(url, defaults, actions);
    }]);
