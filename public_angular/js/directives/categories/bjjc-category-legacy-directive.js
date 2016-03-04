
angular.module('myApp.categories').
directive('bjjCategoryLegacy', ['RecursionHelper',
                  function(RecursionHelper) {
  return {
    restrict: "E",
    replace: true,
    scope: { categories: "=", 
             category: '=' },
    templateUrl: "/directives/categories/bjj-category-legacy.html",
    compile: function(element) {
      return RecursionHelper.compile(element);
    }
  };
}]);




