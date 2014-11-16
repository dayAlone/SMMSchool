###
Meteor.publish 'days', ()->
	return Days.find({}, options)
###