Template.Days4.events = 
	'change .article textarea:not(.editor)' : ()->
		getData(false)
	'keydown .article textarea:not(.editor)' : ()->
		getData()
		
		
	