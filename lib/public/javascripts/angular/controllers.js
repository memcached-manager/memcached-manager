controllers.controller('ListKeysController', ['$scope', 'Keys', 'Key', '$state', function($scope, Keys, Key, $state) {
  $scope.keys = Keys.get();
  console.log('xpto');
}]);

controllers.controller('NewKeyController', ['$scope', 'Keys', 'Key', '$state', function($scope, Keys, Key, $state) {
  $state.transitionTo('keys.new');

  $scope.newKey = function() {
    $state.transitionTo('keys.new');
  }

  $scope.createKey = function() {
    pair = { key: $scope.key.key, value: $scope.key.value };
    Key.save(pair, function(response){
      if (response.errors.length == 0) {
        $state.transitionTo('keys');
      }
    });
  }
}]);
