app.config(function($stateProvider, $routeProvider){
  $stateProvider
    .state('showKeys', {
      url: "",
      views: {
        "keys": {
          templateUrl: "/templates/keys.html.erb",
          controller: 'ListKeysController'
        },
        "key": {
          template: 'Welcome to memcached manager'
        }
      }
    })
    .state('processingRequest', {
      url: "/processing",
      views: {
        "keys": {
          templateUrl: "/templates/keys.html.erb",
          controller: 'ListKeysController'
        },
        "key": {
          template: 'Processing...'
        }
      }
    })
    .state('newKey', {
      url: "/new",
      views: {
        "keys": {
          templateUrl: "/templates/keys.html.erb",
          controller: 'ListKeysController'
        },
        "key": {
          templateUrl: "/templates/new.html.erb",
        }
      }
   });
})
