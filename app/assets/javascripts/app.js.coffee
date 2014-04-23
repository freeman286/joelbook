$ () ->
  start = () ->
    app.realtime.connect();
    postsRouter = new app.routers.Post();
    Backbone.history.start({pushState: true});

  start();