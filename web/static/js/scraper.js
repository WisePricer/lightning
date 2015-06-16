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
      data['data'] = $.parseJSON(script[0]);
      data['script'] = script.splice(1);
    } else {
      data['data'] = {};
      data['script'] = script;
    }

    $.post('/api/scripts',data,function(response) {
      $('textarea').hide();
      var $e = document.createElement('ul');
      var full_script = $('.text-editor textarea').val().split('\n');
      console.log(full_script);
      $.each(full_script, function(i,v) {
        var screenshot_url;
        if(first_line_is_json && i == 0) {
          screenshot_url = '';
        } else {
          screenshot_url = response['debug'][i-1]['screenshot_url'];
        }
        var li = document.createElement('li');
        $(li).attr('data-screenshot', screenshot_url).text(v);
        $($e).append(li);
      });
      $('.text-editor').append($e);

      $('li').on('click',function() {
        if($(this).attr('data-screenshot') !== '') {
          $('.screenshot_container').html('<img src="' + $(this).attr('data-screenshot') + '"/>');
        }
      });
    });
  });
});
