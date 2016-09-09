$(document).on('turbolinks:load', function(){
  $('select').material_select();
  $parent = $("#teacher-new-student-parent-form");

  if ($("#user_parent").val() !== "") {
    $parent.hide();
    $parent.find("input").val("");
  }


  $("#user_parent").change(function () {
    if ($(this).val() === "")
      $parent.show();
    else {
      $parent.hide();
      $parent.find("input").val("");
    }
  });
});
