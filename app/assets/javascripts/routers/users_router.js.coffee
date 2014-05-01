app.routers.Users = Backbone.Router.extend
  initialize : ->
    @users = new app.collections.Users [{name: "Joel", encrypted_password: "example"}]
    @users.fetch
    alert(JSON.stringify(@users))