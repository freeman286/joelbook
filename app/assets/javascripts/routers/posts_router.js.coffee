app.routers.Post = Backbone.Router.extend
  initialize : ->
    @posts = new app.collections.Posts window.posts
    @indexView = new app.views.posts.Index
      collection : @posts

    @formView = new app.views.posts.Form()

    $('body').append @indexView.render()
    $('body').append @formView.render()

  routes :
    "posts/" : "index"
    "posts/new" : "new"
    "posts/:id" : "show"
    "posts/:id/edit" : "edit"

  index : () ->
    $('.action-view').show()
    @indexView.$el.show()

  edit : (id) ->
    $('.action-view').show()
    @formView.model = @posts.get id
    @formView.render()
    @formView.$el.show()      

  new : () ->
    $('.action-view').show()
    @formView.clear()
    @formView.$el.show()     