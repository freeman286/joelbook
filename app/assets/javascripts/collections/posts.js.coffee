app.collections.Posts = Backbone.Collection.extend
  model : app.models.Posts
  url : '/posts'

  initialize : () ->
    app.on 'posts', @handle_change, @
    @sort_key = 'time'

  handle_change : (message) ->
    switch message.action
      when 'create'
        @add message.obj
      when 'update'
        model = @get message.id
        model.set message.obj
      when 'destroy'
        @remove message.obj
        
  comparator : (a, b) ->
    a = a.get(@sort_key)
    b = b.get(@sort_key)
    (if a > b then 1 else (if a < b then -1 else 0))      

  sort_by_time = ->
    @sort_key = "time"
    @sort()
    return