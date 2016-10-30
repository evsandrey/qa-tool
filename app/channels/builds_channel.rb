# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class BuildsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def broadcast
    ActionCable.server.broadcast "builds_channel", message: data['body']
  end
end
