var grasshopper = angular.module('grasshopper', ['ngRoute']);

grasshopper.controller('BoardsCtrlAjax', function($scope, $http)
{
$http({method: 'GET', url: '/boards.json'}).success(function(data)
{
$scope.boards = data; // response data
});
});

grasshopper.controller('MessagesCtrlAjax', function($scope, $http)
{
$http({method: 'GET', url: '/boards/1/messages.json'}).success(function(data)
{
$scope.messages = data; // response data
});
});

grasshopper.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/account', {
        templateUrl: 'account.html'
      }).
      when('/messages', {
        templateUrl: 'messages.html'
      }).
      when('/', {
        templateUrl: 'home.html'
      })
  }]);
