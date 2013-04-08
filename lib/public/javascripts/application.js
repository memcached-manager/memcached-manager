'use strict';

// Setting up
var services = angular.module("keysServices", []); 
var controllers = angular.module("keysControllers", []);
var app = angular.module('memcached-keys', ['ngResource', 'keysServices', 'keysControllers']);

// This is a workaround to send data(post/put) as form instead of clean request payload
services.config(function ($httpProvider) {
  $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8';
  $httpProvider.defaults.transformRequest = function(data){
      if (data === undefined) {
          return data;
      }
      return $.param(data);
  }
});
