describe("Factory Response", function() {
  var service;

  beforeEach(function(){
    module('keysServices');
    inject(function(Response){
      service = Response;
    });
  });

  describe("valid method", function(){
    beforeEach(function(){
      response = jasmine.createSpyObj('response', ['errors']);
    });

    it("tells if a response is valid", function(){
      response.errors.andReturn('undefined');
      expect(service.valid(response)).toBeFalsy;
    });

    it("tells if a response isn't valid", function(){
      response.errors.andReturn('xpto');
      expect(service.valid(response)).toBeTruthy;
    });
  });
});
