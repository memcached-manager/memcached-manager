describe('CreateKeyController', function(){
  describe('createKey', function(){
    var scope,
        controller,
        state,
        location,
        ctrl;

    var mockedResponse = {
      valid: function(res){ return true; }
    }

    beforeEach(module('memcached-keys'));

    beforeEach(inject(function($rootScope, $controller, $state, $location, $state, $route, Keys){
      scope = $rootScope.$new();
      scope.pair = function(){
        return {key: 'foo', value: 'bar'};
      }

      state = $state;

      ctrl = $controller('CreateKeyController', {
        $scope: scope,
        $state: state,
        $location: location,
        Response: mockedResponse
      });
    }));

    it('creates successfully', inject(function($httpBackend, $state){
      $httpBackend.expectGET('/templates/keys.html.erb').respond([]);
      $httpBackend.expectPOST('/api/keys.json').respond({key:"adads",bytes:"16",expires_at:"2013-10-09 21:02:19 -0300",expired:true});

      scope.$on('$stateChangeStart', function(event, toState, toParams, fromState, fromParams){
        expect(toState.name).toEqual('processingRequest');
      });

      scope.createKey();
    }));
  });
});
