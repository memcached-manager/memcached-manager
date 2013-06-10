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

controllers.controller('NewKeyController', ['$scope', 'Keys', 'Key', '$state', function($scope, Keys, Key, $state){
  $state.transitionTo('keys.new');

  $scope.newKey = function(){
    $state.transitionTo('keys.new');
  }

  $scope.createKey = function(){
    pair = { key: $scope.key.key, value: $scope.key.value };

    Keys.save(pair, function(response){
      //TODO: verify if there's errors b4 doing dat & show error...

      // Adding key to list
      $scope.keys.unshift(response);
      $state.transitionTo('keys');
    });
  }
}]);
