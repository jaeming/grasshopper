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

grasshopper.service('userService', function($http, $q) {
  var self = this;
  self.user = null;
  self.getUser = function(){
    if (self.user != null)
      {
        return self.user;
      }
    self.user = $http({method: 'GET', url: 'http://grasshopperapi.herokuapp.com/user/current_user.json'}).success(
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