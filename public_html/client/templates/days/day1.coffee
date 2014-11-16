Template.Days1.rendered = ()->
	getData = ()->
		data = {}
		$('.article textarea').each ()->
			data[$(this).attr('name')] = $(this).val()
		console.log data
		return data

	$('.article textarea').on 'change', ()->
		data = 
			day     : $('.day').data 'id'
			answers : getData()
		Meteor.call('answerUpdate', data)

	