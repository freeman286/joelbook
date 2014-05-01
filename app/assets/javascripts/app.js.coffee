$ () ->
  start = () ->
    app.realtime.connect();
    postsRouter = new app.routers.Posts();
    usersRouter = new app.routers.Users();
    #Backbone.history.start({pushState: true});

  start();
  