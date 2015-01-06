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
