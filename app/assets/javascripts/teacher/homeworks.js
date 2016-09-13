$(document).on('turbolinks:load', function(){
  function teacherHomeworkNew() {
    var nextTaskToShow = 0;

    $tasks = $("ul#homework-task-list li");
    $tasks.hide();

    var AddTask = function () {
      if (nextTaskToShow === $tasks.length) return;
      $tasks.eq(nextTaskToShow).show();
      nextTaskToShow++;
    };


    var RemoveTask = function (el) {
      if (nextTaskToShow === 0) return;
      $parent_li = $(el).parents("li").eq(0);
      $parent_li.hide();

      // if task has been retrieved from the db, then mark it for deletion
      // otherwise, just clean up and recycle!

      task_id = $parent_li.find("input:hidden[name*='[id]']").val();
      if (task_id) {
        // mark for deletion
        $parent_li.find("input:hidden[name*='[_destroy]']").val(true);
        // remove it from the UL but keep it in the form
        // for later destruction on submit
        $parent_form = $parent_li.parents("form").first();
        $parent_form.append($parent_li);
      } else {
        $parent_li.find("input").val("");
        $parent_ul = $parent_li.parents("ul").first();
        $parent_ul.append($parent_li);
      }

      $tasks = $("ul.collection li"); // refresh the task list
      nextTaskToShow--;
    };

    AddTask();
    for (var i = nextTaskToShow; i < $tasks.length; i++)
      if ($tasks.eq(i).find("input[name*=item]").val() !== "") AddTask();

    return {
      AddTask: AddTask,
      RemoveTask: RemoveTask
    };
  }

  teacher_new_homework_view = teacherHomeworkNew();
});

function toggleTaskURLFieldDisabledStatus($el) {
  $url = $el.parents('li').find('input[name*=url]');
  if ($el.val() !== "") {
    $url.val("");
    $url.attr('disabled', true);
  }
  else
    $url.removeAttr('disabled');
}

function enableURLInputFields() {
  $("ul.collection li").find("input[name*=url]").removeAttr("disabled");
}

function removeTaskAttachment(el) {
  $containing_div = $(el).parents("div").eq(0);
  $containing_div.eq(0).siblings("#edit-homework-new-file").show();
  $containing_div.hide();
  // mark attachment for deletion
  $parent_li = $(el).parents("li").eq(0);
  $parent_li.find("input:hidden[name*='[delete_attachment]']").val(true);
}
