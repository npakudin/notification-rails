# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.client = new Faye.Client('/faye', { retry: 5 })

jQuery ->
  $j = jQuery
  tablet_id = ($j '#data').data 'tablet_id'

  client.subscribe '/tablet_' + tablet_id, (payload) ->
    alert('Got a message: ' + payload.text);
