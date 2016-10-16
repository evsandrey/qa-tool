App.global = App.cable.subscriptions.create "GlobalChannel",
  connected: ->
    console.log("WebSocket connected");

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log(data);
    insertNewMessage(data['message']);
    updateScrollbar();
    
  broadcast: ->
    @perform 'broadcast',message: message
