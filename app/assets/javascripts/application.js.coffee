#= require jquery
#= require jquery_ujs
#= require underscore
#= require bootstrap
#= require backbone
#= require auth
#= require config
#= require realtime
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./templates
#= require_tree ./views
#= require_tree ./routers
#= require app

$(document).ready ->
  if window.posts is undefined
    $('.action-view').hide()
    
  if (document.referrer is "http://" + window.location.host) or (document.referrer is "http://" + window.location.host + "/posts/new")
    $("#modal").modal "show"
    return
  
  $('#new_post').click ->
    $('#modal').modal "show"
    return