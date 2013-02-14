App.TasksController = Ember.ArrayController.extend({
  needs: ["task_new", "task"],
  itemController: "task"
});

