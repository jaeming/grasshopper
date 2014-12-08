var grasshopper = angular.module('grasshopper', ['ui.router', 'ngAnimate', 'ngResource', 'grasshopper.services']);


// Services
angular.module('grasshopper.services', []).factory('Board', function($resource) {
  return $resource('/boards/:id', { id: '@id' }, {
    update: {
      method: 'PUT'
    }
  });
})
.factory('Message', function($resource) {
  return $resource('/boards/:id/messages', { id: '@id' }, {
    update: {
      method: 'PUT'
    }
  });
});


// Controllers
grasshopper.controller('BoardListController', function($scope, $state, $window, Board) {
 $scope.boards = Board.query();
});

grasshopper.controller('BoardViewController', function($scope, $stateParams, Board) {
 $scope.board = Board.get({ id: $stateParams.id });
});

grasshopper.controller('MessageListController', function($scope, $state, $stateParams, $window, Message) {
 $scope.messages = Message.query({ id: $stateParams.id });
});


// Routes
angular.module('grasshopper').config(function($stateProvider) {
  $stateProvider.state('boards', { // index
    url: '/boards',
    templateUrl: 'pages/home.html',
    controller: 'BoardListController'
  }).state('viewBoard', { // show
    url: '/boards/:id/view',
    templateUrl: 'pages/board-view.html'
  }).state('newBoard', { // create
    url: '/boards/new',
    templateUrl: 'pages/board-add.html',
    controller: 'BoardCreateController'
  }).state('editBoard', { // update
    url: '/boards/:id/edit',
    templateUrl: 'pages/Board-edit.html',
    controller: 'BoardEditController'
  }).state('messages', { // index
    url: '/boards/:id/messages',
    templateUrl: 'pages/messages.html',
    controller: 'MessageListController'
  });
}).run(function($state) {
  $state.go('boards');
});


