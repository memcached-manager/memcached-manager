describe("Factory Resource", function() {
  var $httpBackend;

  beforeEach(function(){
    module('keysServices');
    module('ngResource');
    inject(function($injector){
      $httpBackend = $injector.get('$httpBackend');
    });

    window.basePath = '';
  });

  it("requests a bunch of keys correctly", inject(function(Keys){
    $httpBackend.expectGET('/api/keys.json').respond([]);
    Keys.get();
  }));

  it("requests the save of a key correctly", inject(function(Keys){
    $httpBackend.expectPOST('/api/keys.json').respond([]);
    Keys.save({});
  }));

  it("requests the update of key correctly", inject(function(Keys){
    $httpBackend.expectPUT('/api/keys.json').respond([]);
    Keys.update({});
  }));

  it("requests the find of a key correctly", inject(function(Key){
    $httpBackend.expectGET('/api/keys/xpto.json').respond([]);
    Key.find({key: 'xpto'});
  }));

  it("requests the delete of a key correctly", inject(function(Key){
    $httpBackend.expectDELETE('/api/keys/xpto.json').respond([]);
    Key.delete({key: 'xpto'});
  }));

  it("requests the stats correctly", inject(function(Stats){
    $httpBackend.expectGET('/api/stats.json').respond([]);
    Stats.all();
  }));
});
