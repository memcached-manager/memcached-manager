filters.filter('configs', function() {
  return function(args, keyToRead){
    var key, value;

    key = Object.keys(args)[0];

    if (key != undefined) {
      switch(keyToRead) {
        case "numberOfKeys":
          value = args[key]['curr_items'];
          break;
        case "bytes":
          value = args[key]['bytes'];
          break;
        case "maxBytes":
          value = args[key]['limit_maxbytes'];
          break;
        case "percentUsage":
          value = (args[key]['bytes'] / args[key]['limit_maxbytes']).toFixed(2);
          break;
      }
    }

    return value;
  }
}).filter('humanize_size', function() {
  return function(args) {
    return humanize.filesize(args);
  }
});

