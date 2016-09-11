$(document).on('turbolinks:load', function(){
  function teacherHomeworkNew() {
    var nextTaskToShow = 0;

    $tasks = $("ul#new-home-work-task-list li");
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
      $parent_li.find("input").val("");

      $parent_ul = $parent_li.parents("ul").first();
      $parent_li.detach();
      $parent_ul.append($parent_li);
      $tasks = $("ul.collection li");

      nextTaskToShow--;
    };

    AddTask();
    for (var i = nextTaskToShow; i < $tasks.length; i++)
      if ($tasks.eq(i).find("input").val() !== "") AddTask();

    return {
      AddTask: AddTask,
      RemoveTask: RemoveTask
    };
  }

  teacher_new_homework_view = teacherHomeworkNew();
});

function toggleTaskURLFieldDisabledStatus($el) {
  $url = $el.parents('li').find('input[name*=url]');
  if ($el.val() !== "")
    $url.attr('disabled', true);
  else
    $url.removeAttr('disabled');
}
