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
}).filter('shortify_key', function() {
  return function(args) {
    if (args.length > 13) {
      args = args.substring(0,13) + '...';
    } else {
      args;
    }
    return args;
  }
}).filter('humanize_timestamp', function() {
  return function(args) {
    function humanizeTimestamp(ttl) {
      var minutes,
          hours,
          days,
          years,
          humanizedTimestamp;

      minutes = parseInt(ttl / 60);
      hours = parseInt(minutes / 60);
      days = parseInt(hours / 24);
      years = parseInt(days / 365);

      if (days < 30) {
        humanizedTimestamp = parseInt(days) + 'd';
      }

      if (hours < 24) {
        humanizedTimestamp = parseInt(hours) + 'h';
      }

      if (minutes < 60) {
        humanizedTimestamp = parseInt(minutes) + 'm';
      }

      if (minutes == 0) {
        humanizedTimestamp = ttl + 's';
      }

      return humanizedTimestamp;
    }
    expires_in = args.expires_in
    infinite = args.infinite

    var ttl = expires_in - Math.floor(Date.now() / 1000);

    if (infinite) {
      return '∞';
    } else if (ttl <= 0) {
      return 'expired'
    } else {
      return humanizeTimestamp(ttl);
    }
  }
});

