app.collections.Users = Backbone.Collection.extend
  model : app.models.User
  url : '/auth.json'