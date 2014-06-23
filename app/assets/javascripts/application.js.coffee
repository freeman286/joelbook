#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require underscore
#= require backbone
#= require auth
#= require config
#= require realtime
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./routers
#= require_tree .
#= require js-routes
#= require jquery.remotipart


$(document).ready ->
  $(".action-view").css "display", "none"  if window.posts is undefined
  $("#user_name").val('')
  
  $("#user_avatar").change ->
      $("#crop_link").hide()
      $("#avatar_img").hide()
      $(".file_upload").html("<span class='uploaded'>" + $("#user_avatar").val().split('\\').pop(); + "</span")
      return
  
  $("#user_name").bind 'keyup', (e) ->
    $("#user_name").trigger "submit"
  
  $("#user_name").focusout ->
    $("#user_name").val('')
    setTimeout (->
      $(".user-dropdown-menu").delay(800).hide()
      return
    ), 200
    
  $('a[data-toggle="tab"]:first').tab 'show'
      
  $("#channel_user_name").bind 'keyup', (e) ->
    $("#channel_user_name").trigger "submit"
  
  $("#channel_user_name").focusout ->
    $(".panel-body").animate({height: 73}, 500);
    $("#channel_user_name").val('')
    setTimeout (->
      $(".channel-dropdown-menu").delay(800).hide()
      return
    ), 200
    
  readURL = (input) ->
    if input.files and input.files[0]
      reader = new FileReader()
      reader.onload = (e) ->
        $("#form_img").animate({height: 0}, 0).show().animate({height: 200}, 500);
        $("#form_img").attr "src", e.target.result
        return

      reader.readAsDataURL input.files[0]
    return
  
  $(document.body).on 'change', "#form_img_input", (e) ->
    readURL this
    $("#new_image").submit()
    return
    
  $(document.body).on 'click', "#new_post", (e) ->  
    window.image_url = ''
    $("#form_img").hide()
    $("#form_img").attr "src", '' 