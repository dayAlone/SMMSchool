Meteor.methods
	activeUser : (invite)->
		if @userId && invite
			Meteor.users.update(@userId, {$set : { 'profile.email' : invite.email, "profile.isActive": true }});
			if invite.admin
				Roles.addUsersToRoles @userId, ['admin']
			Invitations.update({_id: invite._id}, {$set: {used: true}})

		return true
   
Accounts.onCreateUser (options, user)->
	options.profile.isActive = false

	if (user.services.vk)
		options.profile.image = user.services.vk.photo_big

	if (user.services.twitter)
		options.profile.image = user.services.twitter.profile_image_url

	if (user.services.facebook)
		options.profile.image = "http://graph.facebook.com/#{user.services.facebook.id}/picture?type=square&width=120&height=120‌​"

	if (options.profile)
    	user.profile = options.profile;
    

	return user;