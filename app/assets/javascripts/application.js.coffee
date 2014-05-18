#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require underscore
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
  
  $("#user_avatar").change ->
      $("#crop_link").hide()
      $("#avatar_img").hide()
      $(".file_upload").html("<span class='uploaded'>" + $("#user_avatar").val().split('\\').pop(); + "</span")
      return
  
  
  