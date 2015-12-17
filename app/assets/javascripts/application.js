//
// Application js manifest (fighters_guild)
//
//
//= require jquery
//= require jquery_ujs
//
//= require foundation
//= require utils
// 
//= require_tree .
//

$(document).ready(function() {
  $('.badge-item').mouseover(function() {
    $('.mouseover', this).show();
  });
  $('.badge-item').mouseout(function() {
    $('.mouseover', this).hide();
  });

  $('ul.video-tasks li').mouseover(function() {
    $('.mouseover', this).show();
  });
  $('ul.video-tasks li').mouseout(function() {
    $('.mouseover', this).hide();
  });

  if ($('.fg-videos-show').length > 0 || $('.fg-videos--tasks').length > 0 ) {
    $('input.task').click(function() {
      var value = $(this).prop('checked') ? true : false;
      var name = $(this).attr('param-name');
      var data = {};
      data[name] = value;
      var pv_id = $(this).attr("player-video-id");
      $.post( "/fighters_guild/player_videos/" + pv_id, data ).done(function() {
        $(".video-tasks-response").html("Saved");
      });
    });
  }

  if ($(".fg-videos--tasks").length > 0) {
    $(".edit_player_video").on("ajax:success", function(e, data, status, xhr) {
      console.log(data);
      $(".task-" + data.task_id + "-status").html(data.status);
    });
  }

});


