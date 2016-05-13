@Results = new Mongo.Collection("results")

Meteor.methods
	resultUpdate: (data) ->
		if Roles.userIsInRole Meteor.userId(), ['admin']
			author = @userId

			day    = Days.findOne data.day
			if !day
				throw new Meteor.Error('invalid-day', 'День не найден');

			user    = Meteor.users.findOne data.user
			if !user
				throw new Meteor.Error('invalid-user', 'Ученик не найден');

			result = Results.findOne
				authorId : Meteor.userId()
				userId   : user._id
				dayId    : day._id

			if !result
				result = 
					authorId    : Meteor.userId()
					authorName  : Meteor.user().profile.name
					authorImage : Meteor.user().profile.image
					userId      : user._id
					dayId       : day._id
					text        : data.text

				result._id = Results.insert result

			else
				Results.update
						_id: result._id
					,
						$set:
							text: data.text

			return result._id