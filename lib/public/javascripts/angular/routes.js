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
          template: 'Welcome to memcached manager' // Show memcached stats here <3
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
          template: 'Processing...' // Show a image or somethin', lol
        }
      }
    })
    .state('editKey', {
      url: "/edit/:key", // :key is going to be inside $stateParams whenever it's injected in a controller here
      views: {
        "keys": {
          templateUrl: "/templates/keys.html.erb",
          controller: 'ListKeysController'
        },
        "key": {
          templateUrl: "/templates/edit.html.erb",
          controller: 'EditKeyController'
        }
      }
    })
    .state('showKey', {
      url: "/:key", // :key is going to be inside $stateParams whenever it's injected in a controller here
      views: {
        "keys": {
          templateUrl: "/templates/keys.html.erb",
          controller: 'ListKeysController'
        },
        "key": {
          templateUrl: "/templates/show.html.erb",
          controller: 'ShowKeyController'
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
