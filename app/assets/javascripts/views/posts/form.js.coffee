app.views.posts ?= {}

window.Foo =
	bar: (bob) ->
		console.log bob

app.views.posts.Form = Backbone.View.extend
  id : 'form-view'
  className : 'action-view'
  template : JST['templates/posts/form']
  events : {'click input[type=submit]' : 'save'}
  initialize : ->
    @model = new app.models.Posts()
  clear : () ->
    @model = new app.models.Post()
    this.$el.find('input[type=text],input[type=text]').val('')
  serialize : ->
    @model.toJSON()

  formValues : ->
      name : this.$el.find('input[name=name]').val()
      user_name : this.$el.find('input[name=user_name]').val()
  render : ->
    @$el.html @template(@serialize())
    @$el
  save : (evt) ->
  		evt.preventDefault()
    if (hex_md5(window.user.name + window.user.encrypted_password) is window.user.auth)
  	    @isNew = @model.isNew()
  	    @model.save @formValues(),
  	        success : () =>
  	          if @isNew
  	            app.collections.posts.add @model
  	          @clear()
  	          app.navigate '/posts/', true
  	        error :(error) =>
  	          console.log error