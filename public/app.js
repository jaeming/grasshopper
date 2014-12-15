var grasshopper = angular.module('grasshopper', ['ui.router', 'ngAnimate', 'ngResource', 'grasshopper.services']).config(['$httpProvider', function($httpProvider) {
  $httpProvider.defaults.withCredentials = true;
}]);


// Services
angular.module('grasshopper.services', []).factory('Board', function($resource) {
  return $resource('http://grasshopperapi.herokuapp.com/boards/:id', { id: '@id' }, {
    update: {
      method: 'PUT'
    }
  });
})
.factory('Message', function($resource) {
  return $resource('http://grasshopperapi.herokuapp.com/boards/:board_id/messages/:id', { board_id: '@board_id',  id: '@id' }, {
    update: {
      method: 'PUT'
    }
  });
});

grasshopper.service('userService', function($http) {
  this.getUser = function(){
    var user = $http({method: 'GET', url: 'http://grasshopperapi.herokuapp.com/user/current_user.json'}).success(
      function(data) {
        return data;
      });
    return user;
  }});

grasshopper.service('noticeService', function($window){
  this.showPopup=function(notice){
    return $window.confirm(notice);
  }
});


// Controllers

  // BOARDS
grasshopper.controller('BoardListController', function($scope, $state, Board) {
  $scope.boards = Board.query();
});

grasshopper.controller('BoardViewController', function($scope, $state, $stateParams, Board, userService, noticeService) {

  userService.getUser().then(function (response) {
    $scope.user = response.data;
  });

  $scope.board = Board.get({ id: $stateParams.id });

  $scope.updateBoard = function() {
    $scope.board.$update(function() {
      $state.transitionTo('viewBoard', { id: $stateParams.id });
    });
  };
  $scope.deleteBoard = function() {
    if(noticeService.showPopup('Are you sure you want to delete this?')){
      $scope.board.$remove(function() {
        $state.go('boards');
      });
    };
  };
});

grasshopper.controller('BoardCreateController', function($scope, $state, $stateParams, $window, Board, userService) {
  userService.getUser().then(function (response) {
    $scope.user = response.data;
  });
  $scope.board = new Board();
  $scope.addBoard = function() {
    $scope.board.$save(function() {
      $state.go('boards');
    });
  };
});

  // MESSAGES
grasshopper.controller('MessageListController', function($scope, $http, $state, $stateParams, $window, Message, Board, userService, noticeService) {
  userService.getUser().then(function (response) {
    $scope.user = response.data;
  });
  $scope.messages = Message.query({ board_id: $stateParams.id });
  $scope.message = new Message( {board_id: $stateParams.id} );

  $scope.addMessage= function() {
    $scope.message.$save(function() {
      location.reload();
    });
  };

  $scope.deleteMessage = function(board_id, id) {
    if(noticeService.showPopup('Are you sure you want to delete this?')){
      $scope.message.$delete(board_id, id).then(function() {
        location.reload();
      });
    };
  };
});

grasshopper.controller('MessageViewController', function($scope, $state, $stateParams, Message, Board, $window) {
  $scope.message = Message.get({ board_id: $stateParams.board_id, id: $stateParams.id});

  $scope.updateMessage = function() {
    $scope.message.$update(function() {
      $state.go('viewMessage', { board_id: $stateParams.board_id, id: $stateParams.id });
    });
  };
});


  // USER
grasshopper.controller('UserController', function($scope, $state, $http, userService, $window) {
  userService.getUser().then(function (response) {
    $scope.user = response.data;
  });

  $scope.logIn = function(){
    $http({method: 'POST', url: "http://grasshopperapi.herokuapp.com/sessions", data: {email: $scope.email, password: $scope.password}}).success(function(data) {
      $scope.email = "";
      $scope.password = "";
      $window.location.reload();
      $state.go('boards');
    }).error(function(data) {
      $scope.errors = true;
      $scope.details = data.message;
    })
  };

  $scope.signUp = function(){
    $http({method: 'POST', url: "http://grasshopperapi.herokuapp.com/users", data: {email: $scope.email, name: $scope.name, password: $scope.password, password_confirmation: $scope.password_confirmation}}).success(function(data) {
      $scope.email = "";
      $scope.name = "";
      $scope.password = "";
      $scope.password_confirmation = "";
      $window.location.reload();
      $state.go('boards');
    }).error(function(data) {
      $scope.signup_errors = true;
      $scope.signup_details = data.message;
    })
  };

  $scope.logOut = function(){
    $http({method: 'DELETE', url: "http://grasshopperapi.herokuapp.com/sessions/" + $scope.user.id }).success(function(data) {
      console.log(data);
      $window.location.reload();
      $state.go('boards');
    })
  };
})

  // SEARCH
grasshopper.controller('SearchController', function($scope, $http, $state, $stateParams, Message, $window) {
  $scope.search = function(){
    $http({method: 'GET', url: "http://grasshopperapi.herokuapp.com/search/?query=" + $scope.search.query}).success(function(result) {
      $scope.results = result;
    });
  }
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
    templateUrl: 'pages/board-edit.html',
    controller: 'BoardViewController'
  }).state('viewMessage', { // show
    url: 'boards/:board_id/messages/:id/view',
    templateUrl: 'pages/message-view.html',
    controller: 'MessageViewController'
  }).state('newMessage', { // create
    url: '/boards/:board_id/messages/new',
    templateUrl: 'pages/message-add.html',
    controller: 'MessageCreateController'
  }).state('editMessage', { // update
    url: '/boards/:board_id/messages/:id/edit',
    templateUrl: 'pages/message-edit.html',
    controller: 'MessageViewController'
  }).state('account', {
    url: '/account/',
    templateUrl: 'pages/account.html',
    controller: 'UserController'
  }).state('search', {
    url: '/search/',
    templateUrl: 'pages/search.html',
    controller: 'SearchController'
  }).state('api', {
    url: '/api',
    templateUrl: 'pages/api.html'
  });
}).run(function($state) {
  $state.go('boards');
});




