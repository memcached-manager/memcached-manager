window.notification = function(message, type) {
  var color;

  // type of notification to color mapping
  switch(type) {
    case 'success':
      color = 'green';
      break;
    case 'error':
      color = 'red';
      break;
    case 'fatal':
      color = 'red-fatal';
      break;
    case 'info':
      color = 'blue';
      break;
  }

  // if past notification isn't the same as the currrent one
  if ($('.notification-red-fatal').text() != message) {
    // remove current notification div
    if ($('#notification').length) { $('#notification').remove(); }

    // add a new notification with of the desired type and message
    $('.container').prepend('<div id="notification" class="notification-'+ color +'">'+ message +'</div>');
  }

  if (type != 'fatal'){
    setTimeout(function(){
      $('#notification').animate({height: 'toggle', easing: 'swing'}, 1000);
    }, 1000);
  }
}

services.factory('Notification', function() {
  return {
    error: function(message) {
      window.notification(message, 'error');
    },
    fatal: function(message) {
      window.notification(message, 'fatal');
    },
    info: function(message) {
      window.notification(message, 'info');
    },
    success: function(message) {
      window.notification(message, 'success');
    }
  };
});
