var grasshopper = angular.module('grasshopper', ['ngRoute']);

grasshopper.controller('BoardsCtrlAjax', function($scope, $http)
{
$http({method: 'GET', url: '/boards.json'}).success(function(data)
{
$scope.boards = data; // response data
});
});

grasshopper.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/account', {
        templateUrl: 'account.html'
      }).
      when('/', {
        templateUrl: 'home.html'
      })
  }]);