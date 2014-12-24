ready = ->
	$("#sideNav-button").on "click", (evt) ->
		console.log "Button clicked"
		evt.preventDefault()
		$("#sideNav, #modalOverlay").addClass("is-active")

	$("#modalOverlay").on "click", (evt) ->
		$("#sideNav, #modalOverlay").removeClass("is-active")

$(document).ready(ready)
$(document).on('page:load', ready)