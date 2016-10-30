App.suites = App.cable.subscriptions.create "SuitesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    addSuite(data)

  broadcast: ->
    @perform 'broadcast'
