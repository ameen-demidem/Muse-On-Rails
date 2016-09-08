function teacherHomeworkNew() {
  var nextTaskToShow = 0;

  $tasks = $("ul.collection li");
  $tasks.hide();

  var homeworkShowAddTask = function () {
    $tasks.eq(nextTaskToShow).show();
    nextTaskToShow++;
  };

  homeworkShowAddTask();

  return {
    homeworkShowAddTask: homeworkShowAddTask
  };
}
