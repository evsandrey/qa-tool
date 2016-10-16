# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class GlobalChannel < ApplicationCable::Channel
  def subscribed
    stream_from "global_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def broadcast(data)
    ActionCable.server.broadcast "global_channel", message: data['body']
  end
end

