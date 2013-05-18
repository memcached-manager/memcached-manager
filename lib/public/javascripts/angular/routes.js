app.config(['$stateProvider', function($stateProvider){
  $stateProvider
    .state('keys', {
      templateUrl: '/templates/keys.html.erb',
      url: '',
      controller: 'ListKeysController'
    }).state('keys.new', {
      templateUrl: '/templates/new.html.erb',
      url: 'new',
      controller: 'NewKeyController',
      parent: 'keys'
    });
}]);
