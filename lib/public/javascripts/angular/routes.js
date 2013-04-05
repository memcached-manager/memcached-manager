app.config(['$routeProvider', function($routeProvider) {
  $routeProvider.
    when('', {redirectTo: '/' }).
    when('/', {templateUrl: '/templates/keys.html.erb', controller: 'keysController'}).
    when('/new', {templateUrl: '/templates/new.html.erb', controller: 'keysController'}).
    otherwise({redirectTo: '/'});
}]);
