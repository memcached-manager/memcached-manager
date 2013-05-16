// Services
services.factory('Keys', ['$resource', function($resource) {
  return $resource('/api/keys.json', {}, {
    'get':    { method: 'GET', isArray:true },
    'save':   { method: 'POST' }
  });
}]);

services.factory('Key', ['$resource', function($resource) {
  return $resource('/api/keys/:key.json', { key: '@key' }, {
    'delete': { method: 'DELETE' }
  });
}]);
