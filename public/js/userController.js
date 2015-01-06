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