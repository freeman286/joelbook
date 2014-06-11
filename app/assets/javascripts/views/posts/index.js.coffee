app.views.posts ?= {}

app.views.posts.Index = Backbone.View.extend
  id : 'index-view'

  className : 'action-view'

  template : JST['templates/posts/index']

  events : 
    'click a[data-method=delete]' : 'destroy'
  
  initialize : ->
    @collection.on 'reset sort', @.render, @
    @collection.on 'change add remove', @.render, @

  destroy : (evt) ->
    evt.preventDefault()
    $a = $(evt.currentTarget)
    id = $a.attr('data-id')
    model = @collection.get id
    model.destroy()
    @collection.remove model
    app.navigate 'channels/' + window.channel_id + '/posts', true


  serialize : ->
    posts : @collection

  render : ->
    @$el.html @template(@serialize())
    @$el