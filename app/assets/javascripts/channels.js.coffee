$(document).ready ->
  $(document.body).on 'click', ".add_user", (event) ->
    event.preventDefault()
    addUserBtn = $(this)
    $.ajax
      url: Routes.add_channel_path(
        channel_id: addUserBtn.data("channelId"),
        id: addUserBtn.data("id")
      )
      dataType: "json"
      type: "POST"
      success: (e) ->
        alert('success')