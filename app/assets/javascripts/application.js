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
      var commit = $(this).prop('checked') ? "Complete" : "Undo";

      var id = $(this).attr("player-video-id");
      console.log("id is", id);

      var task_id = $(this).attr("task-id");
      console.log("task id is", task_id);

      var data = { commit: commit, id: id, task_id: task_id };
      $.post( "/fighters_guild/player_videos/" + data.id, data ).done(function() {
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


