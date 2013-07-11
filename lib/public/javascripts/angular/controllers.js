controllers.controller('ListKeysController', ['$scope', 'Keys', '$state', '$location', function($scope, Keys, $state, $location){
  $scope.keys = Keys.get();
}]);

controllers.controller('CreateKeyController', ['$scope', 'Keys', '$state', '$location', function($scope, Keys, $state, $location){
  $scope.createKey = function(){
    pair = { key: $scope.key.key, value: $scope.key.value };

    $state.transitionTo('processingRequest');

    Keys.save(pair, function(response){
      //TODO: verify if there's errors b4 doing dat & show error...

      // Refreshing list
      $state.transitionTo('showKeys');
      
      // Redirecting to / so the list gets refreshed 'n shit.
      $location.path('/');
    });
  }
}]);

controllers.controller('DeleteKeyController', ['$state', '$scope', 'Key', '$location', function($state, $scope, Key, $location){
  $scope.removeKey = function(pair){
    $state.transitionTo('processingRequest');

    Key.delete({key: pair.key}, function(response){
      //TODO: verify if there's errors b4 doing dat & show error...

      // Refreshing list
      $state.transitionTo('showKeys');
      
      // Redirecting to / so the list gets refreshed 'n shit.
      $location.path('/');
    });
  }
}]);

controllers.controller('UpdateKeyController', ['$state', '$scope', 'Key', 'Keys', '$location', function($state, $scope, Key, Keys, $location){
  $scope.updateKey = function(){
    pair = { key: $scope.pair.key, value: $scope.pair.value };

    $state.transitionTo('processingRequest');

    Keys.update(pair, function(response){
      //TODO: verify if there's errors b4 doing dat & show error...

      // Refreshing list
      $state.transitionTo('showKeys');
      
      // Redirecting to / so the list gets refreshed 'n shit.
      $location.path('/');
    });
  }
}]);

controllers.controller('EditKeyController', ['$state', '$scope', 'Key', '$location', '$stateParams', function($state, $scope, Key, $location, $stateParams){
  // Set up the current form text 'key' as key
  $scope.pair = Key.find({key: $stateParams.key});
}]);

controllers.controller('BootstrapController', ['$state', function($state){
  $state.transitionTo('showKeys');
}]);
