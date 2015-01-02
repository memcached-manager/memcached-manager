services.factory('QueryParamsSingleton', function() {
  return {
    getQuery: function() {
      return window.stateVariables.searchQuery;
    },
    setQuery: function(query) {
      return window.stateVariables.searchQuery = query;
    }
  };
});
