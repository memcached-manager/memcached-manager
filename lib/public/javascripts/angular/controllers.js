controllers.controller('keysController', ['$scope', 'Keys', 'Key', function($scope, Keys, Key) {
  $scope.keys = Keys.get();

  $scope.getKeys = function() {
    Keys.get();
  };
  
  $scope.createKey = function() {
    console.log(Key.save({ key: $scope.key.key, value: $scope.key.value }));
  }
}]);
