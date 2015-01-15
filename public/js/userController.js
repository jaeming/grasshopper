grasshopper.controller('UserController', function($scope, $state, $http, userService, $window) {
  userService.getUser().then(function (response) {
    $scope.user = response.data;
  });

  $scope.logIn = function(){
    $http({method: 'POST', url: "/user/sign_in", data: {email: $scope.email, password: $scope.password}}).success(function(data) {
      localStorage.setItem('auth_token', data.auth_token);
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
    $http({method: 'POST', url: "/users", data: {email: $scope.email, name: $scope.name, password: $scope.password, password_confirmation: $scope.password_confirmation}}).success(function(data) {
      localStorage.setItem('auth_token', data.auth_token);
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
    var userToken = localStorage.getItem('auth_token');
    $http({method: 'GET', url: "/user/sign_out", headers: {'Authorization': 'Token token=' + userToken}}).success(function(data) {
      console.log(data);
      localStorage.removeItem('auth_token');
      $window.location.reload();
      $state.go('boards');
    })
  };
})