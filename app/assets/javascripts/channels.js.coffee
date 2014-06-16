$(document).ready ->
  $(document.body).on 'click', ".add_user", (event) ->
    event.preventDefault()
    addUserBtn = $(this)
    $.ajax
      url: Routes.add_channel_path( addUserBtn.data("channelId"), addUserBtn.data("id"))
      dataType: "script"
      type: "POST"
      success: (e) ->
  
  $(document.body).on 'click', ".remove_user", (event) ->
    event.preventDefault()
    removeUserBtn = $(this)
    $.ajax
      url: Routes.remove_channel_path( removeUserBtn.data("channelId"), removeUserBtn.data("id"))
      dataType: "script"
      type: "POST"
      success: (e) ->      