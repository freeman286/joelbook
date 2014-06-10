app.routers.Posts = Backbone.Router.extend
  initialize : ->
    @posts = new app.collections.Posts window.posts
    @indexView = new app.views.posts.Index
      collection : @posts

    @formView = new app.views.posts.Form()

    $('.backbone').append @indexView.render()
    $('.backbone').append @formView.render()

  routes :
    "channels/:channel_id/posts" : "index"
    "channels/:channel_id/posts/new" : "new"
    "channels/:channel_id/posts/:id" : "show"
    "channels/:channel_id/posts/:id/edit" : "edit"

  index : () ->
    $('.action-view').show()
    @indexView.$el.show()

  edit : (channel_id, id) ->
    $('.action-view').show()
    @formView.model = @posts.get id
    @formView.render()
    @formView.$el.show()      

  new : () ->
    $('.action-view').show()
    @formView.clear()
    @formView.$el.show()       