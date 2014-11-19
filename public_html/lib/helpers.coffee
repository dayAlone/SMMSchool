@delay = (ms, func) -> setTimeout func, ms

@getData = (timer=true)->
	action = ()->
		console.log 2
		answers = {}
		$('.task textarea:not(.editor)').each ()->
			answers[$(this).attr('name')] = 
				type: 'textarea'
				title: $(this).data 'title'
				value: $(this).val()

		$('.task table').each ()->
			
			head = $(this).find('thead th').map(-> 
				return $(this).text() ).get()
			
			value = []
			$(this).find('tbody tr').each (v,k)->
				data = []
				if $(this).find('td').length != $(this).find('td:empty').length 
					$(this).find('td').each (key, val)->
						data.push $(this).html()
					value.push data
			
			answers[$(this).attr('name')] = 
				type: 'table'
				title: $(this).data 'title'
				head: head 
				value: value
		data = 
			day     : $('.day').data 'id'
			answers : answers
		
		Meteor.call('answerUpdate', data)
	
	if timer
		saveTimer = Session.get "saveTimer"
		clearTimeout(saveTimer)
		Session.set "saveTimer", setTimeout (->
			action()
		), 3000
	else
		action()


UI.registerHelper 'getTable', (table)->
	data = []
	_.each table, (val, key)->
		data.push val

	return data
