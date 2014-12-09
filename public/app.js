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
  return $resource('/boards/:board_id/messages/:id', { board_id: '@board_id',  id: '@id' }, {
    update: {
      method: 'PUT'
    }
  });
});


// Controllers
grasshopper.controller('BoardListController', function($scope, $state, $window, Board) {
 $scope.boards = Board.query();
});

grasshopper.controller('BoardViewController', function($scope, $state, $stateParams, Board) {
  $scope.board = Board.get({ id: $stateParams.id });

  $scope.updateBoard = function() {
    $scope.board.$update(function() {
      $state.transitionTo('viewBoard', { id: $stateParams.id });
  });
 };
});

grasshopper.controller('BoardCreateController', function($scope, $state, $stateParams, $window, Board) {
 $scope.board = new Board();

 $scope.addBoard = function() {
  $scope.board.$save(function() {
  $state.go('boards');
  });
 };
});

grasshopper.controller('MessageListController', function($scope, $state, $stateParams, $window, Message) {
 $scope.messages = Message.query({ board_id: $stateParams.id });
 $scope.message = new Message( {board_id: $stateParams.id} );

  $scope.addMessage= function() {
  $scope.message.$save(function() {
  $state.transitionTo('viewBoard', {id: $stateParams.id});
  });
 };
});

grasshopper.controller('MessageViewController', function($scope, $state, $stateParams, Message, $window) {
 $scope.message = Message.get({ board_id: $stateParams.board_id, id: $stateParams.id});
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
    controller: 'BoardViewController'
  }).state('viewMessage', { // show
    url: 'boards/:board_id/messages/:id/view',
    templateUrl: 'pages/message-view.html',
    controller: 'MessageViewController'
  }).state('newMessage', { // create
    url: '/boards/:board_id/messages/new',
    templateUrl: 'pages/message-add.html',
    controller: 'MessageCreateController'
  });;
}).run(function($state) {
  $state.go('boards');
});


