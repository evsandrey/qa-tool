App.builds = App.cable.subscriptions.create "BuildsChannel",
  connected: ->
    console.log("Builds channel connected");

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log(data);
    addBuild(data);

  broadcast: ->
    @perform 'broadcast'
