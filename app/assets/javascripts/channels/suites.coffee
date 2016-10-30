App.suites = App.cable.subscriptions.create "SuitesChannel",
  connected: ->
    console.log("Suites channel connected");

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    addSuite(data)

  broadcast: ->
    @perform 'broadcast'
