# Code inbox: To be sorted.

ready = ->
	$("#sideNav-button").on "click", (evt) ->
		console.log "Button clicked"
		evt.preventDefault()
		$("#sideNav, #modalOverlay").addClass("is-active")

	$("#modalOverlay").on "click", (evt) ->
		$("#sideNav, #modalOverlay").removeClass("is-active")


	$(".message").each (index) ->
		element = $(@)
		setTimeout ( ->
			element.addClass 'is-visible'
			console.log element
			console.log 'Just added the class to index ' + index
		), index * 5000

		setTimeout ( ->
			element.removeClass 'is-visible'
			console.log element
			console.log 'Just removed the class to index ' + index
		), index * 5000 + 4500


$(document).ready(ready)
$(document).on('page:load', ready)