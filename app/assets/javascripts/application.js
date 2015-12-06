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
// 
// require turbolinks
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

    if ($('.fg-videos-show').length > 0 || $('.fg-videos--tasks').length > 0 ) {
        $('input.task').click(function(a) {
            var value = $(this).prop('checked') ? true : false;
            var name = $(this).attr('param-name');
            var data = {};
            data[name] = value;
            var pv_id = $(this).attr("player-video-id");
            $.post( "/fighters_guild/player_videos/" + pv_id, data ).done(function(data) {
                $(".video-tasks-response").html("Saved");
            });
        });
    }
});


