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
