
angular.module('myApp.categories').
directive('bjjCategory', function($compile) {
  return {
    restrict: "E",
    replace: true,
    scope: {
      category: "="
    },
    templateUrl: "/directives/categories/bjj-category.html",
    link: function(scope, element, attrs, controller, transcludeFn) {
    }
  }
});




