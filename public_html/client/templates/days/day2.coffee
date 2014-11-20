Template.Days2
	.rendered = ()->
		###
		$.fn.editableTableWidget = (options) ->
			"use strict"
			index = 0
			editors = []
			$(this).each (elm, key)->
				
				index++
				
				options.editor = [options.editor] unless $.isArray(options.editor) if options
				
				buildDefaultOptions = ->
					opts = $.extend({}, $.fn.editableTableWidget.defaultOptions)
					opts
				activeOptions  = $.extend(buildDefaultOptions(), options)
				ARROW_LEFT     = 37
				ARROW_UP       = 38
				ARROW_RIGHT    = 39
				ARROW_DOWN     = 40
				ENTER          = 13
				ESC            = 27
				TAB            = 9
				element        = $(this)
				editor         = activeOptions.editor
				active         = undefined
				hideEditor     = (editor, active) ->
					evt = $.Event("hide")
					active.trigger evt, editor.val(), active
					editor.hide()
					return

				showEditor     = (select) ->
					active = element.find("td:not([noedit]):focus")
					if active.length
						evt = $.Event("show")
						active.trigger evt
						index = active.index()
						editor = $("#" + active.parents("table").attr("id") + "-editor")
						editor.val(active.text()).removeClass("error").show().offset(active.offset()).css(active.css(activeOptions.cloneProperties)).width(active.width()).height(active.height()).focus()
						editor.select()	if select
					return

				setActiveText  = ->
					text = editor.val()
					evt = $.Event("change")
					originalContent = undefined
					return true	if active.text() is text or editor.hasClass("error")
					originalContent = active.html()
					active.html(text).trigger evt, text
					return

				movement       = (element, keycode, start, end) ->
					start = (if (typeof start is "undefined") then true else start)
					end = (if (typeof end is "undefined") then true else end)
					if keycode is ARROW_RIGHT and end
						return element.next("td")
					else if keycode is ARROW_LEFT and start
						return element.prev("td")
					else if keycode is ARROW_UP and start
						return element.parent().prev().children().eq(element.index())
					else return element.parent().next().children().eq(element.index())	if keycode is ARROW_DOWN and end
					[]

				$.each editor, (k, ed)->
					$(ed)
						.clone()
						.appendTo(element.parent())
						.attr("id", "table-" + index + "-editor")
						.css("position", "absolute")
						.hide()
						.blur( ->
							setActiveText()
							hideEditor editor, active
							return
						)
						.keydown((e) ->
							if e.which is ENTER
								setActiveText()
								hideEditor editor, active
								active.focus()
								e.preventDefault()
								e.stopPropagation()
							else if e.which is ESC
								editor.val active.text()
								e.preventDefault()
								e.stopPropagation()
								hideEditor editor, active
								active.focus()
							else if e.which is TAB
								active.focus()
							else
								possibleMove = movement(active, e.which, @selectionEnd is 0, @selectionStart is @value.length)
								if possibleMove.length > 0
									possibleMove.focus()
									e.preventDefault()
									e.stopPropagation()
							return
						)
						.on( "input paste", ->
							evt = $.Event("validate")
							active.trigger evt, editor.val()
							if evt.result is false
								editor.addClass "error"
							else
								editor.removeClass "error"
							return
						)
					editors.push $("#table-" + index + "-editor")
				element
					.attr("id", "table-" + index)
					.css("cursor", "pointer")
					.on("DOMSubtreeModified", ->
						$(this).find("td").prop "tabindex", 1
						evt = $.Event("refresh")
						$(this).trigger evt
					)
					.on("click keypress dblclick", showEditor)
					.keydown((e) -> 
						prevent = true
						possibleMove = movement($(e.target), e.which)
						if possibleMove.length > 0
							possibleMove.focus()
						else if e.which is ENTER
							showEditor false
						else if e.which is 17 or e.which is 91 or e.which is 93
							showEditor true
							prevent = false
						else
							prevent = false
						if prevent
							e.stopPropagation()
							e.preventDefault()
						return
					)
					.find("td").prop("tabindex", 1)

				$(window).on "resize", ->
					$.each editors, (key, editor)->
						if editor.is(":visible")
							editor.offset(active.offset()).width(active.width()).height active.height()	
				
				return

		$.fn.editableTableWidget.defaultOptions =
			cloneProperties: [
				"padding"
				"padding-top"
				"padding-bottom"
				"padding-left"
				"padding-right"
				"text-align"
				"font"
				"font-size"
				"font-family"
				"font-weight"
				"border"
				"border-top"
				"border-bottom"
				"border-left"
				"border-right"
			]
			editor: $("<input>")
		
		$('.task table')
			.editableTableWidget
				editor: $('<textarea>').addClass('editor')
			.on 'change' : (evt)->
				getData(false)
				return false
		###		
		
Template.Days2.events = 
	'change .article textarea:not(.editor)' : ()->
		getData(false)
	'keydown .article textarea:not(.editor)' : ()->
		getData()
	'input .article .task table tbody td, keydown .article .task table tbody td' : (e)->
		table = $(e.target).parents('table')
		if table.hasClass 'clean'
			table.removeClass 'clean'
		if table.find('tbody tr:last-of-type td').length != table.find('tbody tr:last-of-type td:empty').length
			col = table.find('tbody tr:last-of-type td').length
			table.find('tbody').append '<tr></tr>'
			for i in [0...col]
				table.find('tbody tr:last-of-type').append '<td contenteditable="true"></td>'
		getData()
		
		
	