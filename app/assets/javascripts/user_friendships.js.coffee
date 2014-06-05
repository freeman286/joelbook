window.userFriendships = []
$(document).ready ->
  $.ajax
    url: Routes.user_friendships_path(format: "json")
    dataType: "json"
    type: "GET"
    success: (data) ->
      window.userFriendships = data
      return

  $(document.body).on 'click', "#add-friendship", (event) ->
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
        window.friendId = e.id
        addFriendshipBtn.fadeOut()
        BlockBtn.fadeOut()
        $("#friend-status").html "<a href='/user_friendships/" + addFriendshipBtn.data("friendId") + "' class='btn btn-danger' data-friend-id='" + addFriendshipBtn.data("friendId") + "' id='unfriend-user'>Unfriend User</a>"
        return

    return
    
  $(document.body).on 'click', "#unfriend-user", (event) ->
    event.preventDefault()
    addFriendshipBtn = $(this)
    BlockBtn = $("#block-user")
    $.ajax
      url: Routes.user_friendship_path(
        id: window.friendId
      )
      dataType: "json"
      type: "DELETE"
      success: (e) ->
        addFriendshipBtn.fadeOut()
        BlockBtn.fadeIn()
        $("#friend-status").hide
        $("#friend-status").html "<a href='/user_friendships/new?friend_id=" + addFriendshipBtn.data("friendId") + "' class='btn btn-success' data-friend-id='" + addFriendshipBtn.data("friendId") + "' id='add-friendship'>Add Friend</a>"
        $("#friend-status").fadeIn()
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
        BlockBtn.fadeOut()
        $("#add-friendship").fadeOut()
        $("#friend-status").animate({height:'0px'}, 500)
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
        BlockBtn.fadeOut()
        $("#add-friendship").fadeIn()
        $("#friend-status").animate({height:'34px'}, 500)
        $("#block-status").html "<a href='/user_friendships/" + BlockBtn.data("friendId") + "/block?friend_id=" + BlockBtn.data("friendId") + "' class='btn btn-danger' data-friend-id='" + BlockBtn.data("friendId") + "' id='block-user'>Block User</a>"
        return

    return

  return