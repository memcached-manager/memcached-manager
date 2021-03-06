'use strict';

// Setting up
var services = angular.module("keysServices", []); 
var controllers = angular.module("AppControllers", []);
var filters = angular.module("AppFilters", []);
var app = angular.module('memcached-keys', ['ngResource', 'ui.state', 'keysServices', 'AppControllers', 'AppFilters']);

// This is a workaround to send data(post/put) as form instead of clean request payload
services.config(function ($httpProvider) {
  $httpProvider.defaults.withCredentials = true;
  $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8';
  $httpProvider.defaults.headers.put['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8';
  $httpProvider.defaults.transformRequest = function(data){
    if (data === undefined) {
      return data;
    }
    return $.param(data);
  }
});


$('#openTerminal').click(function() {
  $('.bottom-container').css('width', '100%');
  $('.bottom-container').css('height', '100%');
  $('#terminal').terminal(function(command, term) {
    var customCommands = ['clear', 'CLEAR', 'quit', 'QUIT'] ;

    if(customCommands.indexOf(command) == -1) {
      $.ajax({
        url: "/api/run.json",
        dataType: 'json',
        method: 'POST',
        data: {command: command},
      }).done(function(response) {
        term.echo(response.response);
      });
    } else {
      switch(command){
        case 'CLEAR':
          term.clear();
          break;
        case 'quit':
        case 'QUIT':
          $('.bottom-container').css('width', 0);
          $('.bottom-container').css('height', 0);
          break;
      }
    }
  }, {
      greetings: 'This is a memcached session, all commands are sent to your configured server.\nTo clear the terminal screen, type the command CLEAR. Or to quit, type QUIT.',
      name: 'memcached client',
      enabled: false,
      prompt: 'Memcached Command> '});
});
