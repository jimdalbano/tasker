App.TaskNewView = Em.View.extend({
	templateName: "tasks/task_new",

	// The handling of a 'save' could just as easily have been handled by 
	// responding to an {{action}} helper on the controller, but since 
	// there's UI work involved, we'll handle the submit event of the 
	// form here, and delegate the saving to the controller.
	submit: function() {
		this.task = this.get('controller').get('content');
		if (this.task.get('isValid')) {
			this.get('controller').send('addTask');

			this.$('#new_title').focus();

			// LEARN: why, after adding a Task and setting the controller's content
			// to a new instance of Task, does the title input retain the value 
			// of the previous Task instance while the description textarea does not. 
			// Clearing it manually for now.
			this.get('controller').get('content').set('title', '');
		}
	}

});