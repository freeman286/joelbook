window.app.realtime =
  connect : () ->
    window.app.socket = io.connect('http://' + window.location.hostname + ':5001');

    window.app.socket.on 'rt-change', (message) ->
      window.app.trigger 'posts', message




