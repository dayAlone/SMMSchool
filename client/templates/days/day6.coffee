timer = false
timer2 = false

Template.Days6
	.rendered = ()->
		options =
			responsive: true
			maintainAspectRatio: true

		colors = ["#f9d551", "#b9c84b", "#3c7d71", "#377a91", "#1e4e7f", "#04225c", "#74317d", "#b43d6b", "#d2553f", "#eb743d", "#ef9856", "#f1a651"]
		timer = setInterval (->
			if $('canvas').is(':visible')
				clearInterval timer
				$('canvas').each ()->
					col = $(this).data('col')
					new Chart($(this)[0].getContext("2d")).Doughnut $('body').find("table[name='t1'] tbody tr").map((val)->
						if $(this).find('td:nth-child(1)').text().length > 0
							return {
								label: $(this).find('td:nth-child(1)').text()
								value: parseInt($(this).find("td:nth-child(#{col})").text())
								color: $(this).find('td:nth-child(4) .color-picker').css('background-color')
							}
					), options
		), 1000

		

Template.Days6.events = 
	'change .article textarea:not(.editor)' : ()->
		getData(false)
	'keydown .article textarea:not(.editor)' : ()->
		getData()
	'input .article .task table tbody td, keydown .article .task table tbody td' : (e)->
		
		if $.inArray($(e.target).index(),[1,2]) != -1 && (e.keyCode < 48 || e.keyCode > 57) && $.inArray(e.keyCode, [37,38,39,40,13,27,9,8,46]) == -1
			return false
		
		if $.inArray(e.keyCode, [37,38,39,40,13,27,9,8,46]) == -1
			clearTimeout(timer2)
			timer2 = setTimeout (->
				i = $(e.target).parents('tr').index()
				c = $(e.target).index()
				tr = $(e.target).parents('tr')
				$.each Chart.instances, (key, val)->
					if this.segments[i]
						if c == 0
							this.segments[i].label = $(e.target).text()
						if c==1 || c==2
							value = parseInt($(e.target).text())
							if !value
								value =0
						if c == parseInt($(this.chart.canvas).data('col')) - 1
							this.segments[i].value = value
						
					else if tr.find('td:nth-child(1)').text().length > 0
						col = $(this.chart.canvas).data('col')
						value = parseInt(tr.find("td:nth-child(#{col})").text())
						if !value
							value = 0
						this.addData
						    value: value
						    color: tr.find('td:nth-child(4) .color-picker').css('background-color')
						    label: tr.find('td:nth-child(1)').text()
					
					Chart.instances[key].update()
			
			), 500
			

		table = $(e.target).parents('table')
		if table.hasClass 'clean'
			table.removeClass 'clean'
		if table.attr('name') == 't1'
			if table.find('tbody tr:last-of-type td').length != table.find('tbody tr:last-of-type td:empty').length+1
				col = table.find('tbody tr:last-of-type').clone().find('td').html('').end()
				table.append col
				table.find('tbody tr:last-of-type td:last-of-type').html("<div class=\"color-picker\" style=\"background:#{randomColor()};\"></div>")
		else
			if table.find('tbody tr:last-of-type td').length != table.find('tbody tr:last-of-type td:empty').length
				col = table.find('tbody tr:last-of-type').clone().find('td').html('').end()
				table.append col
		getData()
		
		
	