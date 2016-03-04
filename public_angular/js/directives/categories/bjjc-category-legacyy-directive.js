
angular.module('myApp.categories').
directive('bjjCategoryLegacyy', ['RecursionHelper',
                  function(RecursionHelper) {
  return {
    restrict: "E",
    replace: true,
    scope: { categories: "=", 
             category: '=',
             parentId: '=',
             selectedId: '='
           },
    templateUrl: "/directives/categories/bjj-category-legacy-2.html",
    compile: function(element) {
      return RecursionHelper.compile(element);
    }
  };
}]);




