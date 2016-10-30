App.builds = App.cable.subscriptions.create "BuildsChannel",
  connected: ->
    console.log("Builds channel connected");

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel

  broadcast: ->
    @perform 'broadcast'
