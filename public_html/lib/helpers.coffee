@getData = ()->
		answers = {}
		$('.article textarea:not(.editor)').each ()->
			answers[$(this).attr('name')] = 
				type: 'textarea'
				title: $(this).data 'title'
				value: $(this).val()

		$('.article table').each ()->
			
			answers[$(this).attr('name')] = 
				type: 'table'
				title: $(this).data 'title'
				value: table.tableToJSON
					ignoreEmptyRows : true

		data = 
			day     : $('.day').data 'id'
			answers : answers

		Meteor.call('answerUpdate', data)