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
  var i, expanded_category_items;

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

  /**
   * localStorage
   */
  if (typeof Storage !== 'undefined') {

    expanded_category_items = localStorage.getItem("expanded_category_items");
    if ("string" === typeof expanded_category_items) {
      expanded_category_items = expanded_category_items.split(",");

      console.log("expanded_category_items from local storage:", expanded_category_items);

      for (i=0; i<expanded_category_items.length; i++) {
        $("ul#"+expanded_category_item[i]).show();
      }
    }

    $(".categories-tree .addToggle").click(function() {
      var expanded_category_items, idx, category_id, is_visible;

      console.log('this is', $(this));

      category_id = $("ul", $(this).next()).attr("id");
      is_visible = $(this).next().is(":visible") ? true : false;
      expanded_category_items = localStorage.getItem("expanded_category_items");

      console.log("saving category id", category_id, "as", is_visible);

      if ("string" === typeof expanded_category_items) {
        expanded_category_items = expanded_category_items.split(",");
        idx = expanded_category_items.indexOf(category_id);
        if (!is_visible) { // not visible, let's save that
          if (idx !== -1) {
            console.log("Problem: index of not previously hidden category in hidden categories must be -1.");
          }
          expanded_category_items.push( category_id );
          console.log('saving expanded category');
        } else {
          if (idx === -1) {
            console.log("Problem: a previously hidden category_id is not in the hidden list!");
          }
          expanded_category_items.splice(idx, 1);
        }
        localStorage.setItem("expanded_category_items", expanded_category_items.join(","));
      } 
    });

  } else {
    console.log("localStorage is not defined!");
  }
  

});


