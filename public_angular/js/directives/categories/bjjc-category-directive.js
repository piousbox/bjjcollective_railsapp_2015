
angular.module('myApp.categories').
directive('bjjCategory', ['RecursionHelper',
                  function(RecursionHelper) {
  return {
    restrict: "E",
    replace: true,
    scope: { categories: "=", 
             category: '=' },
    templateUrl: "/directives/categories/bjj-category.html",
    compile: function(element) {
      return RecursionHelper.compile(element);
    }
  };
}]);




