// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//
//= require foundation
//= require utils
// 
//= require_tree .

$(document).ready(function() {
    $('.badge-item').mouseover(function() {
        $('.mouseover', this).show();
    });
    $('.badge-item').mouseout(function() {
        $('.mouseover', this).hide();
    });

    if ($('.fg-videos-show').length > 0) {
        var player_video_id = $(".player-video-id").attr("player-video-id");

        $('input.task-1').click(function() {
            var data;
            if ($("input.task-1").prop('checked')) {
                data = { task_1_ok: true };
            } else {
                data = { task_1_ok: false };
            }
            $.post( "/fighters_guild/player_videos/" + player_video_id, data ).done(function(data) {
                $(".task-1-response").html("Saved");
            });
        });

        $('input.task-2').click(function() {
            var data;
            if ($("input.task-2").prop('checked')) {
                data = { task_2_ok: true };
            } else {
                data = { task_2_ok: false };
            }
            $.post( "/fighters_guild/player_videos/" + player_video_id, data ).done(function(data) {
                $(".task-2-response").html("Saved");
            });
        });

        $('input.task-3').click(function() {
            var data;
            if ($("input.task-3").prop('checked')) {
                data = { task_3_ok: true };
            } else {
                data = { task_3_ok: false };
            }
            $.post( "/fighters_guild/player_videos/" + player_video_id, data ).done(function(data) {
                $(".task-3-response").html("Saved");
            });
        });

    }
});


