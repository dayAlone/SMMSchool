@delay = (ms, func) -> setTimeout func, ms

UI.registerHelper '$in_array', (a, b)->
	inArray = false
	_.each b, (v,k)->
		if v.toString() == a.toString()
			inArray = true
	return inArray

UI.registerHelper '$check', (a)->
	pos = 0;
	if a
		pos = a.indexOf( 'cdn' );
		
		if pos == -1
			return a;
		else
			str = /http:\/\/www.ucarecdn.com\/(.*?)\//g
			x = a.replace(/http:\/\/www.ucarecdn.com\/(.*?)\//, '$1')
			return x

@getData = (timer=true)->
	action = ()->
		console.log 2
		
		answers = {}
		
		$('.task textarea:not(.editor)').each ()->
			answers[$(this).attr('name')] = 
				type: 'textarea'
				title: $(this).data 'title'
				value: $(this).val()

		$('.task table:not(.clean)').each ()->
			
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
		
		$('.task input[type=checkbox]:checked').each ()->
			if !answers[$(this).attr('name')]
				answers[$(this).attr('name')] = {
					type       : 'checkbox'
					value      : [],
					value_text : [],
					title      : $('body').find(".#{$(this).attr('name')}-title").text()
				}
			
			answers[$(this).attr('name')].value.push $(this).val()
			answers[$(this).attr('name')].value_text.push $('body').find("label[for='#{$(this).attr('id')}']").text()

		$('.task .image').each ()->
			if $(this).val().length > 0
				answers[$(this).attr('name')] = 
					type: 'image'
					title: $(this).data 'title'
					value: $(this).val()

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
