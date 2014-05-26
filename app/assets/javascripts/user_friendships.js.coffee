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

  $(document.body).on 'click', "#block-user", (event) ->
    event.preventDefault()
    BlockBtn = $(this)
    $.ajax
      url: Routes.block_user_friendship_path((BlockBtn.data("friendId")))
      dataType: "json"
      type: "PUT"
      success: (e) ->
        BlockBtn.hide()
        $("#add-friendship").hide()
        $("#block-status").html "<a href='/user_friendships/" + BlockBtn.data("friendId") + "/block?friend_id=" + BlockBtn.data("friendId") + "' class='btn btn-success' data-friend-id='" + BlockBtn.data("friendId") + "' id='unblock-user'>Unblock User</a>"
        return
        return
        return

    return
    
  $(document.body).on 'click', "#unblock-user", (event) ->
    event.preventDefault()
    BlockBtn = $(this)
    $.ajax
      url: Routes.unblock_user_friendship_path((BlockBtn.data("friendId")))
      dataType: "json"
      type: "PUT"
      success: (e) ->
        BlockBtn.hide()
        $("#add-friendship").show()
        $("#block-status").html "<a href='/user_friendships/" + BlockBtn.data("friendId") + "/block?friend_id=" + BlockBtn.data("friendId") + "' class='btn btn-danger' data-friend-id='" + BlockBtn.data("friendId") + "' id='block-user'>Block User</a>"
        return

    return

  return