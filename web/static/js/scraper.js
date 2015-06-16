var $ = require('web/static/js/jquery-1.11.3.min')

$(document).ready(function() {
  $('#run-scraper').on('click',function() {
    var script = $('.text-editor textarea').val().split('\n');
    var first_line_is_json = true;
    var data = {};
    try {
      eval('var obj = ' + script[0])
    } catch(error) {
      first_line_is_json = false;
    }

    if(first_line_is_json) {
      data['data'] = script[0];
      data['script'] = script.splice(1);
    } else {
      data['data'] = {};
      data['script'] = script;
    }

    $.post('/api/scripts',data);
  });
});
