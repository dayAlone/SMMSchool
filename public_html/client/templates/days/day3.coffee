timer = false
Template.Days3
	.rendered = ()->
		options =
			showTooltips: false
			responsive: true
			maintainAspectRatio: true
			onAnimationComplete: (e)->
				$(this.chart.canvas).parent().find('img').show()

		colors = ["#f9d551", "#b9c84b", "#3c7d71", "#377a91", "#1e4e7f", "#04225c", "#74317d", "#b43d6b", "#d2553f", "#eb743d", "#ef9856", "#f1a651"]
		$.getScript "http://ucarecdn.com/widget/1.4.5/uploadcare/uploadcare-1.4.5.min.js", ()->
			widget = uploadcare.Widget('[role=uploadcare-uploader]')
			widget.onUploadComplete (info)->
				getData(false)

		timer = setInterval (->
			if $('.circle').is(':visible')
				clearInterval timer
				$('.circle').each ()->
					new Chart($(this)[0].getContext("2d")).Doughnut colors.map((val)->
						return {
							value: 1
							color: val
						}
					), options
		), 1000

		

Template.Days3.events = 
	'change .article textarea:not(.editor)' : ()->
		getData(false)
	'keydown .article textarea:not(.editor)' : ()->
		getData()
		
		
	