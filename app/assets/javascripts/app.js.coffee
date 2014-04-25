$ () ->
  start = () ->
    app.realtime.connect();
    postsRouter = new app.routers.Posts();
    Backbone.history.start({pushState: true});

  start();