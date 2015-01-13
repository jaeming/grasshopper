grasshopper.controller('SearchController', function($scope, $http, $state, $stateParams, Message, $window) {
  $scope.search = function(){
    $http({method: 'GET', url: "/search?q=" + $scope.search.query}).success(function(data) {
      $scope.results = data;
    });
  }
});