Meteor.publish 'days', ()->
	return Days.find({})

Meteor.publish 'invitations', (code)->
	return Invitations.find({}, {invitationId: code})

Meteor.publish 'answers', ()->
	if Roles.userIsInRole @userId, ['admin']
		return Answers.find({})
	else
		return Answers.find({}, {userId : @userId, reactive:false })

Meteor.publish 'results', ()->
	if Roles.userIsInRole @userId, ['admin']
		return Results.find({}, { authorId : @userId})
	else
		return Results.find({}, { userId : @userId })

Meteor.publish 'adminUsers', ()->
	if Roles.userIsInRole @userId, ['admin']
		return Meteor.users.find({}, {profile: {isActive: true}});
	else
		return false
