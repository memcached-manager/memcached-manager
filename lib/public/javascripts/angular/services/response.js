services.factory('Response', function() {
  return {
    valid: function(response) {
      return typeof(response.errors) == 'undefined';
    },
    errors: function(response) {
      return response.errors[0];
    }
  };
});
