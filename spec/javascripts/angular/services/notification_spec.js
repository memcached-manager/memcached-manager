describe("Factory Notification", function() {
  var service;
  var message;

  beforeEach(function(){
    module('keysServices');
    inject(function(Notification){
      service = Notification;
    });
    message = "Some random message";

    window.basePath = '';
  });

  describe("alert method", function(){
    it("notificates the user with an alert", function(){
      noty = jasmine.createSpy('noty');
      service.alert(message);
      expect(noty).toHaveBeenCalledWith({text: message, type: 'alert'});
    });
  });

  describe("error method", function(){
    it("notificates the user with an error", function(){
      noty = jasmine.createSpy('noty');
      service.error(message);
      expect(noty).toHaveBeenCalledWith({text: message, type: 'error'});
    });
  });

  describe("info method", function(){
    it("notificates the user with an info", function(){
      noty = jasmine.createSpy('noty');
      service.info(message);
      expect(noty).toHaveBeenCalledWith({text: message, type: 'information'});
    });
  });

  describe("success method", function(){
    it("notificates the user with as success", function(){
      noty = jasmine.createSpy('noty');
      service.success(message);
      expect(noty).toHaveBeenCalledWith({text: message, type: 'success'});
    });
  });

});
