app.views.posts ?= {}

app.views.posts.Form = Backbone.View.extend
  id : 'form-view'
  className : 'action-view'
  template : JST['templates/posts/form']
  events :
    'click #save' : 'save'
    
  appendHtml : (cv, iv) ->
    cv.$el.prepend iv.el
    return
  
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
      user_id : window.user.id
      user_img_url: window.user.avatar_url
      channel_id: window.channel_id
      time: if @model.isNew() then Math.round(new Date() / 1000) else @model.time
      
  render : ->
    @$el.html @template(@serialize())
    @$el
  save : (evt) ->
  		evt.preventDefault()
    @isNew = @model.isNew()
    @model.save @formValues(),
        success : () =>
          @clear()
          app.navigate 'channels/' + window.channel_id + '/posts', true
          if @isNew
            app.collections.Posts.add @model
            
        error :(error) =>
          console.log error
          