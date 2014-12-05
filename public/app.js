var grasshopper = angular.module('grasshopper', ['ngRoute', 'ngAnimate']);

// Controllers
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

grasshopper.controller('UsersCtrlAjax', function($scope, $http)
{
$http({method: 'GET', url: '/user/current_user.json'}).success(function(data)
{
$scope.user = data; // response data
});
});

grasshopper.controller('CreateBoardCtrl', function($scope, $http)
{
$scope.createBoard = function(){
  $http({method: 'POST', url: "/boards", data: {title: $scope.title, text: $scope.text}}).success(function(data) {
    $scope.text = "";
    $scope.title = "";
    console.log(data)
  })
};
}
);

// Routes
grasshopper.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/account', {
        templateUrl: 'pages/account.html'
      }).
      when('/messages', {
        templateUrl: 'pages/messages.html'
      }).
      when('/', {
        templateUrl: 'pages/home.html'
      }).
      when('/user', {
        templateUrl: 'pages/user.html'
      }).
      when('/new_board', {
        templateUrl: 'pages/newboard.html',
        controller: "CreateBoardCtrl"
      }).
      when('/new_message', {
        templateUrl: 'pages/newmessage.html'
      }).
      when('/api', {
        templateUrl: 'pages/api.html'
      })
  }]);
