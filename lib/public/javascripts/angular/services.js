// Services
services.factory('Keys', ['$resource', function($resource) {
   return $resource('/api/keys.json', {}, {
      'get':    { method: 'GET', isArray:true },
   });
}]);

services.factory('Key', ['$resource', function($resource) {
   return $resource('/api/keys.json', {}, {
      'save': { method: 'POST' }
   });
}]);
