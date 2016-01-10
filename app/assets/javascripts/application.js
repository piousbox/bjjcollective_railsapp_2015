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
//= require_tree ./technique
//

$(document).ready(function() {
    var i, expanded_category_items;

    $.ajaxSetup({
        headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
    });

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
            var task_id = $(this).attr("task-id");
            var data = { commit: commit, id: id, task_id: task_id };
            console.log('data is', data);

            $.post( "/fighters_guild/player_videos/" + data.id, data ).done(function(data) {
                console.log('data is', data);
                $(".task-" + data.task_id + "-status").html("Saved");
            });
        });
    }
    
    if ($(".fg-videos--tasks").length > 0) {
        $('.undo-task button').click(function() {
            var task_id = $(this).attr('task-id');
            var player_video_id = $(this).attr('player-video-id');
            console.log('lets undo', task_id, 'in', player_video_id);
        });
        $('.complete-task button').click(function() {
            console.log('lets complete');
        });
    }

    /**
     * localStorage
     */
    if (typeof Storage !== 'undefined') {
        expanded_category_items = localStorage.getItem("expanded_category_items");
        if ("string" === typeof expanded_category_items) {
            expanded_category_items = expanded_category_items.split(",");
            while(-1 !== expanded_category_items.indexOf("")) {
                expanded_category_items.splice(expanded_category_items.indexOf(""), 1);
                localStorage.setItem("expanded_category_items", expanded_category_items.join(","));
            }
            for (i=0; i<expanded_category_items.length; i++) {
                if("" !== expanded_category_items[i]) {
                    $("ul#"+expanded_category_items[i]).show();
                }
            }
            
        }

        $(".categories-tree .addToggle").click(function() {
            var expanded_category_items, idx, category_id, is_visible;
            category_id = $(this).next().attr("id");
            expanded_category_items = localStorage.getItem("expanded_category_items")||[];
            if ("string" === typeof expanded_category_items) {
                expanded_category_items = expanded_category_items.split(",")
            }
            idx = expanded_category_items.indexOf(category_id);
            is_visible = idx === -1; // ? false : true;
            if (is_visible) { // just expanded it, let's save that
                if (idx !== -1) {
                    console.log("Problem! saving already saved expanded category.");
                } else {
                    expanded_category_items.push( category_id );
                }
            }
            else if (!is_visible) { // not visible, let's save that
                if (idx === -1) {
                    console.log("Problem! Cannot find saved category to remove it.");
                } else {
                    expanded_category_items.splice(idx, 1);
                }
            }
            localStorage.setItem("expanded_category_items", expanded_category_items.join(","));
        });
    } else {
        console.log("Problem! localStorage is not defined!");
    }
    
    
});


