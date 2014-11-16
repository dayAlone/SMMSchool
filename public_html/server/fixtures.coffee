Meteor.methods
	activeUser : (invite)->
		if @userId && invite
			if invite.admin
				Meteor.users.update(@userId, {$set : { 'profile.email' : invite.email, "profile.isActive": true, "profile.isAdmin": true }});
			else
            	Meteor.users.update(@userId, {$set : { 'profile.email' : invite.email, "profile.isActive": true }});
            Invitations.update({_id: invite._id._str}, {$set: {used: true}})

		return true
   
Accounts.onCreateUser (options, user)->
	options.profile.isActive = false
	if (options.profile)
    	user.profile = options.profile;
	return user;