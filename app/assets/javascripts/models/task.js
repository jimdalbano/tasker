App.Task = DS.Model.extend({
  title: DS.attr('string'),
  description: DS.attr('string'),
  due_date: DS.attr('string'),

	isValid: function() {
		if ( this.get('title') && this.get('title') !== '' ) { 
			return true; 
		}
		return false;
	}.property('title')

});
