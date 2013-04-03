'use strict';

// Setting up
var services = angular.module("keysServices", []); 
var controllers = angular.module("keysControllers", []);
var app = angular.module('memcached-keys', ['ngResource', 'keysServices', 'keysControllers']);

// Routes
app.config(['$routeProvider', function($routeProvider) {
  $routeProvider.
    when('', {redirectTo: '/' }).
    when('/', {templateUrl: '/templates/keys.html.erb', controller: 'keysController'}).
    otherwise({redirectTo: '/'});
}]);

// Controllers
controllers.controller('keysController', ['$scope', 'Keys', function($scope, Keys) {
  $scope.keys = Keys.get();

  $scope.getKeys = function() {
    Keys.get();
  };
}]);

// Services
services.factory('Keys', ['$resource', function($resource) {
   return $resource('/api/keys.json', {}, {
      'get': {method: 'GET', isArray:true}
   });
}]);
