app.routers.Users = Backbone.Router.extend
  initialize : ->
    @users = new app.collections.Users
    @users.fetch