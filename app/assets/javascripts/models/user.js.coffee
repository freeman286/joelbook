app.models.User = Backbone.Model.extend
  urlRoot: '/auth'  
  defaults :
    name : ''
    encrypted_password: ''
