App.TaskController = Em.ObjectController.extend({
	
	// NOTE: This bit is a little naive and hackish. It assumes the 
	//				record will save cleanly. Check ember-data for
	//				more information about the rules around transactions
	//				and record status.


	// Managing a state flag here so that we can bind to it
	// in the template and adjust the UI accordingly. 
	isEditing: false,
	
	// Start a new transaction and add the record to it before
	// the record gets dirtied because a transaction will not accept 
	// the addition of a dirty record.
	startEdit: function() {
		if (this.get('isEditing') ||
				this.get('isSaving') ||
				this.get('isDeleted')) {
			return;
		}

		this.transaction = this.get('content.store').transaction();
		this.transaction.add(this.get('content'));
		this.set('isEditing', true);
	},

	cancel: function(){
		if (this.transaction) {
			this.transaction.rollback();
			this.transaction = null;
			this.set('isEditing', false);
		}
	},

	save: function() {
		if (this.get('isValid')) {
			this.transaction.commit();
			this.transaction = null;
			this.set('isEditing', false);
		}
	},

	// LEARN: What happens to a controller instance when its content is destroyed? 
	//					Does Ember view this instance as bunk and throw it out?
	//					Will a transaction left open here prevent its timely disposal?
	delete: function() {
		if (!this.transaction) {
			this.transaction = this.get('content.store').transaction();
			this.transaction.add(this.get('content'));
		}
		this.get('content').deleteRecord();
		this.transaction.commit();
		this.transaction = null;
	}
})