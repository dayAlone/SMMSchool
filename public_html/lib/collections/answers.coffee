@Answers = new Mongo.Collection("answers")

Meteor.methods
	answerUpdate: (data) ->
		if this.isSimulation
			return false
		else
			console.log 'update'
			user = @userId
			day = Days.findOne data.day

			if !day
				throw new Meteor.Error('invalid-day', 'День не найден');

			answer = Answers.findOne
				userId : user
				dayId  : day._id

			if !answer
				answer = 
					userId : user
					dayId  : day._id
					data   : JSON.stringify data.answers

				answer._id = Answers.insert answer

			else
				Answers.update
						_id: answer._id
					,
						$set:
							data: JSON.stringify data.answers
			return answer._id
			