services.factory('Keys', ['$resource', function($resource) {
  return $resource(window.basePath + '/api/keys.json', {}, {
    'get':    { method: 'GET', isArray:true },
    'save':   { method: 'POST' },
    'update': { method: 'PUT' }
  });
}]);

services.factory('Key', ['$resource', function($resource) {
  return $resource(window.basePath + '/api/keys/:key.json', { key: '@key' }, {
    'find':   { method: 'GET' },
    'delete': { method: 'DELETE' }
  });
}]);

services.factory('Stats', ['$resource', function($resource) {
  return $resource(window.basePath + '/api/stats.json', {}, {
    'all':   { method: 'GET' }
  });
}]);

services.factory('Configs', ['$resource', function($resource) {
  return $resource(window.basePath + '/api/config.json', {}, {
    'get':   { method: 'GET' },
    'update':{ method: 'POST' }
  });
}]);

services.factory('Connection', ['$resource', function($resource) {
  return $resource(window.basePath + '/api/status.json', {}, {
    'get':   { method: 'GET' },
  });
}]);
