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
  $(".action-view").css "display", "none"  if window.posts is undefined
  
  $("#show_modal").click ->
    $("#modal").modal "show"
    return
  
  
  