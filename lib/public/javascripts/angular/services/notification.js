services.factory('Notification', function() {
  return {
    alert: function(message) {
      //noty({text: message, type: 'alert'});
    },
    error: function(message) {
      //noty({text: message, type: 'error'});
    },
    info: function(message) {
      //noty({text: message, type: 'information'})
    },
    success: function(message) {
      //noty({text: message, type: 'success'})
    }
  };
});
