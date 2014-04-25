app.routers.Posts = Backbone.Router.extend
  initialize : ->
    @posts = new app.collections.Posts window.posts
    @indexView = new app.views.posts.Index
      collection : @posts

    @formView = new app.views.posts.Form()

    $('.container').append @indexView.render()
    $('.container').append @formView.render()

  routes :
    "posts/" : "index"
    "posts/new" : "new"
    "posts/:id" : "show"
    "posts/:id/edit" : "edit"

  index : () ->
    if window.posts is undefined
      $('.action-view').hide()
    else
      $('.action-view').show()
      @indexView.$el.show()

  edit : (id) ->
    if window.posts is undefined
      $('.action-view').hide()
    else
      $('.action-view').show()
      @formView.model = @posts.get id
      @formView.render()
      @formView.$el.show()      

  new : () ->
    if window.posts is undefined
      $('.action-view').hide()
    else
      $('.action-view').show()
      @formView.clear()
      @formView.$el.show()     