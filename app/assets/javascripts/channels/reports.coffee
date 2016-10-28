App.reports = App.cable.subscriptions.create "ReportsChannel",
  connected: ->
    console.log("Reports channel connected");

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    updateReportIcon(data);
  broadcast: ->
    @perform 'broadcast'
