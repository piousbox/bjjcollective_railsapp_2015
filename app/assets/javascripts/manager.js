//
// Manager js manifest
//
//
//
//= require jquery
//= require jquery_ujs
//
//= require foundation
//= require utils
// 
//= require jquery.uploadfile
// 
//= require_tree ./manager
//

$(document).ready(function() {
  if ($(".manager-photos--subform").length > 0) {
    $("#upload_another_image").click(function() {
      var data = {};
      data['photo'] = new FormData();
      data['photo'].append('file', $("input#photo")[0].files[0]);
      if ($(".manager-photos--subform .questset-id")) {
        data["questset_id"] = $(".manager-photos--subform .questset-id").attr('questset-id');
      }
      if ($(".manager-photos--subform .merit-badge-id")) {
        data["merit_badge_id"] = $(".manager-photos--subform .merit-badge-id").attr('merit-badge-id');
      }
      $.post("/manager/photos", data).done(function(this_data) {
        $(".manager-photos--subform .response").html( this_data );
      });
    });
  }
  
  $("#fileuploader").uploadFile({
    url: "/manager/photos",
    fileName: "file",
    formData: {
      "questset_id": $(".questset-id").attr("questset-id"),
      "merit_badge_id": $(".merit-badge-id").attr("merit-badge-id")
    },
    onSuccess: function(files, data, xhr, pd) {
      console.log('data is', data.photo);
      $(".manager-photos--subform .response").append(
        "<li><img src=\"" + data.photo.thumb_url + "\" alt='' /> " + data.photo.original_path + "</li>"
      );
    }
  });

  if ($(".manager-tasks--form").length > 0) {
    $("#new_task").on("ajax:success", function(e, data, status, xhr) {
      $(".video-task-new-status").html(data.status);
    });

    $(".edit_task").on("ajax:success", function(e, data, status, xhr) {
      $(".video-task-" + data.id + "-status").html(data.status);
    });
  }


});


