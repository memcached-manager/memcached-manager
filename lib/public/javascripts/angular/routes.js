app.config(function($stateProvider, $routeProvider){
  $stateProvider
    .state('showKeys', {
      url: "",
      views: {
        "keys": {
          templateUrl: window.basePath + "/templates/keys.html.erb",
          controller: 'ListKeysController'
        },
        "key": {
          templateUrl: window.basePath + '/templates/stats.html.erb',
          controller: 'StatsController'
        }
      }
    })
    .state('showStats', {
      url: "/stats",
      views: {
        "keys": {
          templateUrl: window.basePath + "/templates/keys.html.erb",
          controller: 'ListKeysController'
        },
        "key": {
          templateUrl: window.basePath + '/templates/stats.html.erb',
          controller: 'StatsController'
        }
      }
    })
    .state('editConfig', {
      url: '/config',
      views: {
        "keys": {
          templateUrl: window.basePath + "/templates/keys.html.erb",
          controller: 'ListKeysController'
        },
        'key': {
          templateUrl: window.basePath + '/templates/config.html.erb',
          controller: 'EditConfigController'
        }
      }
    })
    .state('processingRequest', {
      url: "/processing",
      views: {
        "keys": {
          templateUrl: window.basePath + "/templates/keys.html.erb",
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
          templateUrl: window.basePath + "/templates/keys.html.erb",
          controller: 'ListKeysController'
        },
        "key": {
          templateUrl: window.basePath + "/templates/edit.html.erb",
          controller: 'EditKeyController'
        }
      }
    })
    .state('newKey', {
      url: "/new",
      views: {
        "keys": {
          templateUrl: window.basePath + "/templates/keys.html.erb",
          controller: 'ListKeysController'
        },
        "key": {
          templateUrl: window.basePath + "/templates/new.html.erb",
        }
      }
   })
   .state('showKey', {
     url: "/key/:key", // :key is going to be inside $stateParams whenever it's injected in a controller here
     views: {
       "keys": {
         templateUrl: window.basePath + "/templates/keys.html.erb",
         controller: 'ListKeysController'
       },
       "key": {
         templateUrl: window.basePath + "/templates/show.html.erb",
         controller: 'ShowKeyController'
       }
     }
   });
})
