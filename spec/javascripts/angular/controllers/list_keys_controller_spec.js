describe('ListKeysController', function(){
  describe('keys', function(){
    var scope,
      location;

    // mocking keys resource to return []
    var keysResource = {
      get: function(){
        return [];
      }
    }

    beforeEach(module('memcached-keys'));

    beforeEach(inject(function($rootScope, $controller, $location){
      window.basePath = '';
      location = $location;
      scope = $rootScope.$new();
      ctrl = $controller('ListKeysController', {
        $scope: scope,
        Keys: keysResource,
        $state: {
          transitionTo: function() {
            location.path('/');
          }
        }
      });
    }));

    it('sets up the keys attribute with Keys resource call', function(){
      expect(scope.keys).toEqual([]);
    });

    it('should show keys', function() {
      scope.showKeys();
      expect(location.path()).toBe('/');
    })
  });
});
