angular.module('keys', ['keysService'])
  .config(['$routeProvider', function($provider) {
    $provider
      .when('/', {templateUrl: '/tasks/new.html', controller: TaskNewCtrl})
  }])
  .config(["$httpProvider", function(provider) {
      provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  }]);

angular.module('keysService', ['ngResource']).
  factory('Keys', function($resource) {
    return $resource('/api/keys.json', {}, {
      index: { method: 'GET', isArray: true}
    });
  });
