app.views.posts ?= {}

app.views.posts.Form = Backbone.View.extend
  id : 'form-view'
  className : 'action-view'
  template : JST['templates/posts/form']
  events : {'click input[type=submit]' : 'save'}
  initialize : ->
    @model = new app.models.Posts()
  clear : () ->
    @model = new app.models.Posts()
    this.$el.find('input[type=text]').val('')
  serialize : ->
    @model.toJSON()

  formValues : ->
      name : this.$el.find('input[name=name]').val()
      user_name : window.user.name
      user_img_url: window.user.avatar_url
      
  render : ->
    @$el.html @template(@serialize())
    @$el
  save : (evt) ->
  		evt.preventDefault()
    @isNew = @model.isNew()
    @model.save @formValues(),
        success : () =>
          if @isNew
            app.collections.Posts.add @model
            
          @clear()
          app.navigate '/posts/', true
        error :(error) =>
          console.log error
          