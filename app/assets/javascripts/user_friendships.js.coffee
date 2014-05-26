window.userFriendships = []
$(document).ready ->
  $.ajax
    url: Routes.user_friendships_path(format: "json")
    dataType: "json"
    type: "GET"
    success: (data) ->
      window.userFriendships = data
      return

  $("#add-friendship").click (event) ->
    event.preventDefault()
    addFriendshipBtn = $(this)
    BlockBtn = $("#block-user")
    $.ajax
      url: Routes.user_friendships_path(user_friendship:
        friend_id: addFriendshipBtn.data("friendId")
      )
      dataType: "json"
      type: "POST"
      success: (e) ->
        addFriendshipBtn.hide()
        BlockBtn.hide()
        $("#friend-status").html "<a href='#' class='btn btn-success'>Friendship Requested</a>"
        return

    return

  $("#block-user").click (event) ->
    event.preventDefault()
    BlockBtn = $(this)
    $.ajax
      url: Routes.user_block_path((BlockBtn.data("friendId")))
      dataType: "json"
      type: "POST"
      success: (e) ->
        BlockBtn.hide()
        $("#friend-status").html "<a href='#' class='btn btn-success'>Blocked User</a>"
        return

    return

  return