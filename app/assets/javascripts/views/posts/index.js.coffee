app.views.posts ?= {}

app.views.posts.Index = Backbone.View.extend
  id : 'index-view'

  className : 'action-view'

  template : JST['templates/posts/index']

  events : 
    'click a[data-method=delete]' : 'destroy'
  
  initialize : ->
    @collection.on 'reset', @.render, @
    @collection.on 'change add remove', @.render, @

  destroy : (evt) ->
    evt.preventDefault()
    $a = $(evt.currentTarget)
    id = $a.attr('data-id')
    model = @collection.get id
    app.navigate '/', true
    model.destroy()
    @collection.remove model


  serialize : ->
    posts : @collection

  render : ->
    @$el.html @template(@serialize())
    @$el