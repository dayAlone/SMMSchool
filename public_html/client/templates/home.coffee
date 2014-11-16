Template.home
	.helpers 
		daysList: ()->
			return Days.find({}).map (day, index, cursor)->
				if moment(day.date) < moment()
					day.isActive = true
					day.date = "Материалы доступны"
				else
					day.date = moment(day.date).fromNow()
				return day

Template.dayDetail
	.helpers
		answerList: ()->
			answer = Answers.findOne
				dayID  : @Day._id
				userId : Meteor.userId()
			if answer
				return answer.data
###
Template.home.rendered =  ()->
		$.get '/images/svg/svg-symbols.svg', (data)->
			$('.days').prepend $('svg', data)
###