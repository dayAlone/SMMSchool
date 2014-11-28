Template.Days5
	.helpers
		table: ()->
			day = Days.findOne({sort:2})._id
			if day
				answer = Answers.findOne
					dayId  : day
					userId : Meteor.userId()
				if answer
					if typeof answer.data == 'string'
						answer.data = JSON.parse(answer.data)
					if answer.data.t2
						return answer.data.t2.value
Template.Days5
	.rendered = ()->
		$('input[type=checkbox]')
			.iCheck
				checkboxClass : 'icheckbox_square-blue'
				radioClass    : 'iradio_square-blue'
			.on 'ifChanged', ()->
				getData(false)		

Template.Days5.events = 
	'change .article textarea:not(.editor)' : ()->
		getData(false)
	'keydown .article textarea:not(.editor)' : ()->
		getData()
		
		
	