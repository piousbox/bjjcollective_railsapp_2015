
angular.module('myApp.categories').
directive('bjjCategories', ['RecursionHelper',
                    function(RecursionHelper) {
  return {
    restrict: "E",
    scope: { categories: "=" },
    templateUrl: "/directives/categories/bjj-categories.html",
    compile: function(element) {
      return RecursionHelper.compile(element);
    }
  };
}]);




