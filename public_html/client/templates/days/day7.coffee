timer = false
Template.Days7
	.rendered = ()->

		fileSizeLimit = (min, max)->
			return (fileInfo)->
				if fileInfo.size == null
					return;
				if (min && fileInfo.size < min)
					throw new Error("fileMinimalSize");
				if (max && fileInfo.size > max)
					throw new Error("fileMaximumSize");
					
		if typeof uploadcare != 'undefined'
			$('[role=uploadcare-uploader]').each ()->
				input = $(this);
				widget = uploadcare.Widget(input);
				widget.reloadInfo()

		$.getScript "http://ucarecdn.com/widget/1.4.5/uploadcare/uploadcare-1.4.5.min.js", ()->
			uploadcare.start()
			$('[role=uploadcare-uploader]').each ()->
				input = $(this);
				if ( ! input.data('minSize') && ! input.data('maxSize'))
					return;
				widget = uploadcare.Widget(input);
				widget.validators.push(fileSizeLimit(input.data('minSize'),input.data('maxSize')))
				widget.onUploadComplete (info)->
					getData(false)

		

Template.Days7.events = 
	'change .article textarea:not(.editor)' : ()->
		getData(false)
	'keydown .article textarea:not(.editor)' : ()->
		getData()
		
		
	