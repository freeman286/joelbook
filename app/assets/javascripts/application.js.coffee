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
    
  $("#channel_search_name").bind 'keyup', (e) ->
    $("#channel_search_name").trigger "submit"  
  
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
        asp = $("#form_img").width() / $("#form_img").height()
        $("#form_img").animate({height: 0}, 0).show().animate({height: asp * $('.modal-content').width() / 2}, 500);
        $("#form_img").attr "src", e.target.result
        return

      reader.readAsDataURL input.files[0]
    return
    
  window.notificationsCount = parseInt($.trim($('.notifications-count').html()));
  
  getNotifications = ->
    $.ajax
      url: Routes.notifications_path()
      dataType: "json"
      type: "GET"
      success: (e) ->
        if parseInt(e.notifications_count) isnt 0
          $('.dropdown-menu').hide().replaceWith(e.notifications_to_string).fadeIn('slow');
          $('#index-notification-list').hide().html(e.index_notifications_to_string).fadeIn('slow');
          $('.notifications-count').hide().html(e.notifications_count).fadeIn('slow');
          window.notificationsCount += parseInt(e.notifications_count)
          if window.notificationsCount > 5
            window.notificationsCount = 5
          return
        else
          $('#index-notification-list').html(e.index_notifications_to_string)
          return 
        return

    return
    
  a = setInterval(getNotifications, 10000)
  
  getUserFriendships = ->
    $.ajax
      url: Routes.user_friendships_path()
      dataType: "json"
      type: "GET"
      success: (e) ->
        if parseInt(e.user_friendships_count) isnt 0
          $('#all').hide().html(e.user_friendships).fadeIn()
          return
        if parseInt(e.accepted_count) isnt 0
          $('#accepted').hide().html(e.accepted).fadeIn()
          return
        if parseInt(e.pending_count) isnt 0
          $('#pending').hide().html(e.pending).fadeIn()
          return
        if parseInt(e.blocked_count) isnt 0
          $('#blocked').hide().html(e.blocked).fadeIn()
          return
        if parseInt(e.ignored_count) isnt 0
          $('#ignored').hide().html(e.ignored).fadeIn()
          return      
          
        return

    return
    
  b = setInterval(getUserFriendships, 10000)
  
  $(document.body).on 'change', "#form_img_input", (e) ->
    $("#img_url").val('')
    readURL this
    $("#new_image").submit()
    return
    
  $(document.body).on 'change', "#img_url", (e) ->
    $("#form_img").animate({height: 0}, 0).show().animate({height: $("#form_img").height()}, 500);
    $("#form_img").attr "src", $('#img_url').val()
    $("#new_image").submit()
    
  $(document.body).on 'change', "#youtube_url", (e) ->
    $("#new_video").submit()  
    
  $(document.body).on 'click', "#new_post", (e) ->  
    window.image_url = ''
    window.youtube_url = ''
    $(".container").find('input[type=text]').val('')
    $("#form_img").hide()
    $("#form_img").attr "src", ''
    
  
  $(document.body).on 'click', ".navbar-notification", (e) ->
    $(".navbar-collapse").animate
      scrollTop: $("#notifications-li").offset().top
    , 2000
    return
  
  return
    
    
    