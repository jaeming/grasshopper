function BoardsCtrlAjax($scope, $http)
{
$http({method: 'GET', url: '/boards.json'}).success(function(data)
{
$scope.boards = data; // response data
});
}