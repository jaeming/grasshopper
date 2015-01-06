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