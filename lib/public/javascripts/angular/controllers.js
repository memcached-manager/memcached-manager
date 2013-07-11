/*
controllers.controller('ListKeysController', ['$scope', 'Keys', 'Key', '$state', function($scope, Keys, Key, $state){
  $scope.keys = Keys.get();

  $scope.removeKey = function(pair){
    Key.delete({key: pair.key}, function(response){
      //TODO: verify if there's errors b4 doing dat & show error...

      // Removing the selected pair from the list
      $scope.keys = $scope.keys.filter(function(v){
        if (v.key != pair.key) {
          return v;
        }
      });
    })
  }

  $scope.editKey = function(pair){
    $scope.pair = Key.find(pair);
    $state.transitionTo('keys.edit');
  }

  $scope.updateKey = function(){
    pair = { key: $scope.pair.key, value: $scope.pair.value };

    Keys.update(pair, function(response){
      //TODO: verify if there's errors b4 doing dat & show error...
      
      console.log(response);

      // Adding key to top of the list
      $scope.keys.unshift(response);
      $state.transitionTo('keys');

    });
  }
}]);

controllers.controller('NewKeyController', ['$scope', 'Keys', 'Key', '$state', '$location', function($scope, Keys, Key, $state, $location){
  $state.transitionTo('keys.new');

  $scope.newKey = function(){
    $state.transitionTo('keys.new');
  }
*/

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

controllers.controller('BootstrapController', ['$state', function($state){
  $state.transitionTo('showKeys');
}]);
