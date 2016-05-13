Template.home
	.helpers
		daysList: ()->
			return Days.find({}).map((day, index, cursor)->
				if moment(day.date) < moment() || Roles.userIsInRole Meteor.userId(), ['admin']
					day.isActive = true
					if moment(day.date) > moment()
						day.date = "Для студентов будут доступны " + moment(day.date).fromNow()
					else
						day.date = "Материалы доступны"
				else
					day.date = moment(day.date).fromNow()

				results = Results.find
					dayId  : day._id
					userId : Meteor.userId()

				if results.count() > 0
					day.isAnswer = true


				return day
			).sort (a, b)->
				return a.sort - b.sort

Template.adminAnswers
	.helpers
		answersList: ()->
			if Roles.userIsInRole Meteor.userId(), ['admin']
				users = Meteor.users.find(
					createdAt:
						$gte: new Date(2015,0,1)
					).map((el) ->
						return el._id
					)
				return Answers.find(
						dayId : @Day._id
						userId :
							$in: users
						).map (answer, index, cursor)->

						answer.result = Results.findOne
							dayId    : answer.dayId
							userId   : answer.userId
							authorId : Meteor.userId()

						answer.comments = Results.find(
							dayId    : answer.dayId
							userId   : answer.userId
							authorId : { $ne: Meteor.userId() }
						).fetch()

						data = []
						if (typeof answer.data == 'string' || answer.data instanceof String)
							answer.data = JSON.parse(answer.data)

						$.each answer.data, ()->
							data.push this

						answer.data = data

						if index == 0
							answer.first = true

						author = Meteor.users.findOne(_id : answer.userId)
						if author
							answer.name = ""
							if author.profile.name
								answer.name += author.profile.name
							if author.profile.email
								answer.name += " <small>(" + author.profile.email + ")</small>"
							if author.emails && author.emails[0]
								answer.name += " <small>(" + author.emails[0].address + ")</small>"
						return answer

Template.dayDetail
	.helpers
		dayLoaded: ()->
			return Session.get 'dayLoaded'
		getAnswer: ()->
			answer = Answers.findOne
				dayId  : @Day._id
				userId : Meteor.userId()
			,
				reactive:false
			if answer
				if typeof answer.data == 'string'
					answer.data = JSON.parse(answer.data)
				return answer.data
		resultsList: ()->
			results = Results.find
				dayId  : @Day._id
				userId : Meteor.userId()
			if results.count() > 0
				return results

Template.dayDetail.rendered =  ()->
	if Roles.userIsInRole Meteor.userId(), ['admin']
		$('a.article-trigger').on 'click', (e)->
			$('.article').toggleClass 'hidden'
			$(this).find('span').toggleClass 'hidden'
			e.preventDefault()

Template.dayDetail.events =
	'click input[type=button]' : (e, x, y)->
		parent = $(e.target).parents('.answer')
		textarea = parent.find 'textarea'

		if textarea.val().length == 0
			textarea.focus()
		else
			data =
				day     : $('.day').data 'id'
				user    : parent.data 'id'
				text    : textarea.val()

		Meteor.call('resultUpdate', data)

		e.preventDefault()
