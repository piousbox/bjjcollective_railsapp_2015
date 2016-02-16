'use strict';

angular.module('myApp.categories.service', []).
    factory('Category', ['$resource', 'Config',
                 function($resource,   Config ) {

        var url = Config.api_endpoint + "/categories/:slug/:slug_detail.json";
        var defaults = { videos_page: 1 };
        var actions = { index_by_path:   { method: 'GET', isArray: false, headers: undefined,
                                           url: Config.api_endpoint + "/categories-by-path.json"
                                         },
                        show:    { method: 'GET', isArray: false,
                                   url: Config.api_endpoint + "/categories/:short_slug.json"
                                 },
                        index_1: { method: 'GET', 
                                   url: Config.api_endpoint + "/categories/:slug/:slug_0/:slug_1.json" 
                                 },
                        index_2: { method: 'GET',
                                   url: Config.api_endpoint + "/categories/:slug/:slug_0/:slug_1/:slug_2/:slug_3/page/:videos_page.json"
                                 }
                      };
        return $resource(url, defaults, actions);
    }]);
