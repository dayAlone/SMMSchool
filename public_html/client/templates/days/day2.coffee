Template.Days2.rendered = ()->
	$('table')
		.editableTableWidget
			editor: $('<textarea>').addClass('editor')
		
		.on 'show', (evt, newValue)->
			if $(evt.target).parents('tr').data 'ignore'
				$.each $(evt.target).parents('tr').find('td'), ()->
					$(this).data 'text', $(this).text()
					$(this).text('')
		
		.on 'hide', (evt, newValue)->
			table = $(evt.target).parents('table')
			tr = $(evt.target).parents('tr')
			
			if newValue.length == 0 && tr.data 'ignore'
				$.each tr.find('td'), ()->
					$(this).text $(this).data('text')

			if table.find('tr:last-of-type td').length != table.find('tr:last-of-type td:empty').length
				table.append tr.clone().find('td').text('').end()
		
		.on 'change', (evt, newValue)->
			if $(evt.target).parents('tr').data 'ignore'
				$(evt.target).parents('tr').data 'ignore', false
			console.log $(evt.target).parents('table').tableToJSON
				ignoreEmptyRows : true
			
			#getData()

Template.Days2.events = 
	'change .article textarea:not(.editor)' : ()->
		getData()