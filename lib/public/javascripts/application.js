'use strict';

// Setting up
var services = angular.module("keysServices", []); 
var controllers = angular.module("AppControllers", []);
var filters = angular.module("AppFilters", []);
var app = angular.module('memcached-keys', ['ngResource', 'ui.state', 'keysServices', 'AppControllers', 'AppFilters']);

// This is a workaround to send data(post/put) as form instead of clean request payload
services.config(function ($httpProvider) {
  $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8';
  $httpProvider.defaults.headers.put['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8';
  $httpProvider.defaults.transformRequest = function(data){
    if (data === undefined) {
      return data;
    }
    return $.param(data);
  }
});

jQuery(function($, undefined) {
    $('#terminal').terminal(function(command, term) {
      $.ajax({
        url: "/api/run.json",
        dataType: 'json',
        method: 'POST',
        data: {command: command},
      }).done(function(response) {
        term.echo(response.response);
      });
    }, {
        greetings: 'Memcached Session\nTo clean the terminal, type the command clear.',
        name: 'memcached client',
        onFocus: function (terminal) {
          terminal.resize(500, 500);
        },
        onBlur: function (terminal) {
          terminal.resize(500, 40);
        },
        height: 40,
        enabled: false,
        prompt: 'Memcached Command> '});
});
