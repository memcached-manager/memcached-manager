// Services
services.factory('Keys', ['$resource', function($resource) {
  return $resource('/api/keys.json', {}, {
    'get':    { method: 'GET', isArray:true },
    'save':   { method: 'POST' },
    'update': { method: 'PUT' }
  });
}]);

services.factory('Key', ['$resource', function($resource) {
  return $resource('/api/keys/:key.json', { key: '@key' }, {
    'find':   { method: 'GET' },
    'delete': { method: 'DELETE' }
  });
}]);

services.factory('Notification', function() {
  return {
    alert: function(message) {
      noty({text: message, type: 'alert'});
    },
    error: function(message) {
      noty({text: message, type: 'error'});
    },
    info: function(message) {
      noty({text: message, type: 'information'})
    },
    success: function(message) {
      noty({text: message, type: 'success'})
    }
  };
});
