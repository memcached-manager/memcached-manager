controllers.controller('ListKeysController', ['$scope', 'Keys', 'Key', '$state', function($scope, Keys, Key, $state) {
  $scope.keys = Keys.get();
}]);

controllers.controller('NewKeyController', ['$scope', 'Keys', 'Key', '$state', function($scope, Keys, Key, $state) {
  $state.transitionTo('keys.new');

  $scope.newKey = function() {
    $state.transitionTo('keys.new');
  }

  $scope.createKey = function() {
    pair = { key: $scope.key.key, value: $scope.key.value };
    Key.save(pair, function(response){
      console.log(response);

      //TODO: verify if there's errors b4 doing dat & show error...

      // Adding key to list
      $scope.keys.push(response);

      $state.transitionTo('keys');
    });
  }
}]);
