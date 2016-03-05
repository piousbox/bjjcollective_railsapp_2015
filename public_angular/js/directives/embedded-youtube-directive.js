
angular.module('myApp.videos').
directive('embeddedYoutube', ['$sce',
                      function($sce) {
  return {
    restrict: "EA",
    replace: true,
    scope: { youtubeId: '='
           },
    templateUrl: "/directives/videos/embed-youtube.html",
    link: function(scope) {
      scope.$watch('youtubeId', function(newVal) {
        if (newVal) {
          scope.url = $sce.trustAsResourceUrl("https://www.youtube.com/embed/" + newVal);
        }
      });
    }
  };
}]);




