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
  
  $(document.body).on 'click', ".index-accept-friendship", (event) ->
    event.preventDefault()    
    FriendshipBtn = $(this)
    $.ajax
      url: Routes.accept_user_friendship_path(FriendshipBtn.data("friendshipId"))
      dataType: "json"
      type: "POST"
      success: (e) ->
        $('.friendship-' + FriendshipBtn.data("friendshipId")).hide().html("Friendship is accepted ").fadeIn();
        $('.friendship-actions-' + FriendshipBtn.data("friendshipId")).hide().html("<a href='/user_friendships/'" + FriendshipBtn.data("friendshipId") + " class='btn index-delete-friendship' data-friendship-id='" + FriendshipBtn.data("friendshipId") + "'>Delete Friendship</a>").fadeIn();
        
  $(document.body).on 'click', ".index-delete-friendship", (event) ->
    event.preventDefault()    
    FriendshipBtn = $(this)
    $.ajax
      url: Routes.destroy_user_friendship_path(FriendshipBtn.data("friendshipId"))
      dataType: "json"
      type: "POST"
      success: (e) ->
        $('.user-friendship-' + FriendshipBtn.data("friendshipId")).fadeOut();
  
  $(document.body).on 'click', ".index-decline-friendship", (event) ->
    event.preventDefault()    
    FriendshipBtn = $(this)
    $.ajax
      url: Routes.decline_user_friendship_path(FriendshipBtn.data("friendshipId"))
      dataType: "json"
      type: "POST"
      success: (e) ->
        $('.friendship-' + FriendshipBtn.data("friendshipId")).hide().html("Friendship is ignored ").fadeIn();
        $('.friendship-actions-' + FriendshipBtn.data("friendshipId")).hide().html("<a href='/user_friendships/'" + FriendshipBtn.data("friendshipId") + " class='btn index-accept-friendship' data-friendship-id='" + FriendshipBtn.data("friendshipId") + "'>Accept Friendship</a>").fadeIn();
          
  $(document.body).on 'click', ".index-block-friendship", (event) ->
    event.preventDefault()    
    FriendshipBtn = $(this)
    $.ajax
      url: Routes.block_user_friendship_path(FriendshipBtn.data("friendId"))
      dataType: "json"
      type: "POST"
      success: (e) ->
        $('.friendship-' + FriendshipBtn.data("friendshipId")).hide().html("Friendship is blocked ").fadeIn();
        $('.friendship-actions-' + FriendshipBtn.data("friendshipId")).hide().html("<a href='/user_friendships/'" + FriendshipBtn.data("friendshipId") + " class='btn index-unblock-friendship' data-friendship-id='" + FriendshipBtn.data("friendshipId") + "'>Unblock User</a>").fadeIn();
  
  $(document.body).on 'click', ".index-unblock-friendship", (event) ->
    event.preventDefault()    
    FriendshipBtn = $(this)
    $.ajax
      url: Routes.unblock_user_friendship_path(FriendshipBtn.data("friendId"))
      dataType: "json"
      type: "POST"
      success: (e) ->
        $('.user-friendship-' + FriendshipBtn.data("friendshipId")).fadeOut();                      
  return