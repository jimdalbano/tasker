App.Router.map(function() {
  this.resource('tasks');
});

App.IndexRoute = Em.Route.extend({
  redirect: function() {
    this.transitionTo('tasks');
  }
});

App.TasksRoute = Em.Route.extend({
  model: function() {
    return App.Task.find();
  },

  renderTemplate: function() {
    this.render('tasks/index');
  },

  // Since we're going to be creating a Task without a route for 'new',
  // we'll manage the transaction outside the lifecycle of the controller.
  setupController: function(controller, model) {
    this.task_trans = this.get('store').transaction();
    this.controllerFor('task_new').set('content', this.task_trans.createRecord(App.Task));
  },


  events: {
    addTask: function() {
      this.new_task = this.controllerFor('task_new').get('content');
      if (this.new_task.get('isValid')) {
        this.task_trans.commit();
        this.task_trans = null;
        this.task_trans = this.get('store').transaction();
        this.controllerFor('task_new').set('content', this.task_trans.createRecord(App.Task));
      }
    }
  },

  // Really shouldn't be an issue in this app since there are no other useful routes but
  // since it's a good practice we'll clean up after ourselves.
  exit: function() {
    if (this.task_trans) {
      this.task_trans.rollback();
      this.task_trans = null;
    }
  }
});