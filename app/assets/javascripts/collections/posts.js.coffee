app.collections.Posts = Backbone.Collection.extend
  model : app.models.Posts
  url : '/posts'

  initialize : () ->
    app.on 'posts', @handle_change, @

  handle_change : (message) ->
    switch message.action
      when 'create'
        @add message.obj
      when 'update'
        model = @get message.id
        model.set message.obj
      when 'destroy'
        @remove message.obj

