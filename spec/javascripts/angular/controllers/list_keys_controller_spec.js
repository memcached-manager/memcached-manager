describe('ListKeysController', function(){
  describe('keys', function(){
    var scope;

    // mocking keys resource to return []
    var keysResource = {
      get: function(){
        return [];
      }
    }

    beforeEach(module('memcached-keys'));

    beforeEach(inject(function($rootScope, $controller){
      scope = $rootScope.$new();
      ctrl = $controller('ListKeysController', {
        $scope: scope,
        Keys: keysResource
      });
    }));

    it('sets up the keys attribute with Keys resource call', function(){
      expect(scope.keys).toEqual([]);
    });
  });
});
