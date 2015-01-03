controllers.controller('EditConfigController', ['$scope', 'Configs', '$state', '$location', function($scope, Configs, $state, $location) {
  $scope.config = Configs.get();
}]);

controllers.controller('UpdateConfigController', ['$state', '$scope', 'Configs', '$location', 'Notification', 'Response', function($state, $scope, Configs, $location, Notification, Response) {
  $scope.updateConfig = function() {
    config = { host: $scope.config.host, port: $scope.config.port };

    $state.transitionTo('processingRequest');

    Configs.save(config, function(response) {
      if (Response.valid(response)){ // Checks if response is valid
        Notification.success('Yay! Memcached config updated with success.');

        // Refreshing list
        $state.transitionTo('showKeys');

        // Redirecting to / so the list gets refreshed.
        $location.path('/');
      } else {
        Notification.error(Response.errors(response));
      }
    });
  }
}]);


controllers.controller('ListKeysController', ['$scope', 'Keys', '$state', '$location', 'QueryParamsSingleton', function($scope, Keys, $state, $location, QueryParamsSingleton) {
  $scope.keys = Keys.get();
  $scope.query = QueryParamsSingleton.getQuery();

  $scope.showKeys = function() {
    $state.transitionTo('showKeys');
  };

  $scope.filterByQuery = function() {
    QueryParamsSingleton.setQuery($scope.query);

    $scope.keys = Keys.get({query: $scope.query});
  }
}]);

controllers.controller('CreateKeyController', ['$scope', 'Keys', '$state', '$location', 'Notification', 'Response', function($scope, Keys, $state, $location, Notification, Response) {
  $scope.createKey = function() {
    pair = { key: $scope.pair.key, value: $scope.pair.value };

    $state.transitionTo('processingRequest');

    Keys.save(pair, function(response) {
      if (Response.valid(response)) { // Checks if response is valid
        Notification.success('Yay! Key created with success.');

        // Refreshing list
        $state.transitionTo('showKey', pair);

        // Redirecting to / so the list gets refreshed.
        $location.path('/');
      } else {
        Notification.error(Response.errors(response));
      }
    });
  }
}]);

controllers.controller('DeleteKeyController', ['$state', '$scope', 'Key', '$location', 'Notification', 'Response', function($state, $scope, Key, $location, Notification, Response){
  $scope.removeKey = function(pair) {
    $state.transitionTo('processingRequest');

    Key.delete({key: pair.key}, function(response) {
      if (Response.valid(response)){ // Checks if response is valid
        Notification.info('Yay! Key deleted with success.');

        // Refreshing list
        $state.transitionTo('showKeys');

        // Redirecting to / so the list gets refreshed.
        $location.path('/');
      } else {
        Notification.error(Response.errors(response));
      }
    });
  }
}]);

controllers.controller('UpdateKeyController', ['$state', '$scope', 'Key', 'Keys', '$location', 'Notification', 'Response', function($state, $scope, Key, Keys, $location, Notification, Response) {
  $scope.updateKey = function() {
    pair = { key: $scope.pair.key, value: $scope.pair.value };

    $state.transitionTo('processingRequest');

    Keys.update(pair, function(response) {
      if (Response.valid(response)){ // Checks if response is valid
        Notification.success('Yay! Key updated with success.');

        // Refreshing list
        $state.transitionTo('showKey', pair);

        // Redirecting to / so the list gets refreshed.
        $location.path('/');
      } else {
        Notification.error(Response.errors(response));
      }
    });
  }
}]);

controllers.controller('EditKeyController', ['$state', '$scope', 'Key', '$location', '$stateParams', function($state, $scope, Key, $location, $stateParams) {
  // Set up the current form text 'key' as key
  $scope.pair = Key.find({key: $stateParams.key});
}]);

controllers.controller('StatsController', ['$state', '$scope', 'Stats', '$location', '$stateParams', 'Connection', function($state, $scope, Stats, $location, $stateParams, Connection) {
  // Set up the current form text 'key' as key
  $scope.stats = Stats.all();
  $scope.connection = Connection.get();
}]);

controllers.controller('ShowKeyController', ['$state', '$scope', 'Key', '$location', '$stateParams', function($state, $scope, Key, $location, $stateParams) {
  // Set up the current form text 'key' as key
  $scope.pair = Key.find({key: $stateParams.key});
}]);

controllers.controller('BootstrapController', ['$state', 'Connection', 'Notification', function($state, Connection, Notification) {
  setInterval(function() {
    Connection.get(function(response){
      if (!response.connected) {
        Notification.error('Memcached is out of reach.');
        $state.transitionTo('editConfig');
      };
    });
  }, 1000);

  $state.transitionTo('showKeys');
}]);
