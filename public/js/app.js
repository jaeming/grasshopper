var grasshopper = angular.module('grasshopper', ['ui.router', 'ngAnimate', 'ngResource', 'grasshopper.services']).config(['$httpProvider', function($httpProvider) {
  $httpProvider.defaults.withCredentials = true;
}]);

grasshopper.run(function($http) {
    var userToken = localStorage.getItem('auth_token');
    $http.defaults.headers.common["Authorization"] = "Token token=" + userToken;
});

// Resources
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

// Services
grasshopper.service('userService', function($http) {
  var self = this;
  self.user = null;
  self.getUser = function(){
    if (self.user != null)
      {
        return self.user;
      }
    var userToken = localStorage.getItem('auth_token');
    self.user = $http({method: 'GET', url: '/user/current_user.json', headers: {'Authorization': 'Token token=' + userToken}}).success(
      function(data) {
        return data;
      });
    return self.user;
  }});

grasshopper.service('noticeService', function($window){
  this.showPopup=function(notice){
    return $window.confirm(notice);
  }
});


