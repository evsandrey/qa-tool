class GlobalMessagesController < ApplicationController
  
  def create
    global_message = GlobalMessage.new(global_message_params)
    global_message.user = current_user
    if global_message.save
      ActionCable.server.broadcast 'global_channel',
        message: render_message(global_message),
        user: current_user.first_name
      head :ok
    else 
      render global_message.errors.full_messages
    end
  end
  
  def global_chat
    @q = GlobalMessage.ransack(params[:q])
    @q.sorts = 'created_at asc' if @q.sorts.empty?
    @messages = @q.result.page params[:page]
  end
  
  def map_for_init(selection)
    a = []
    selection.each.with_index do |message,index|
      a[index] = render_to_string :partial => "global_messages/message_init", :locals => {:message_init => message}
    end 
    a
  end
  
  
  def init_chat
    h = Hash.new()
    h["messages"] = []
    if cookies["lastRead"].nil?  
      h["messages"] = map_for_init(GlobalMessage.desc('_id').limit(10))
      h["unread_count"] = 0
    else
      h["messages"] = map_for_init(GlobalMessage.where(created_at: (cookies["lastRead"].to_time..Time.now)).desc('_id'))  
      if h["messages"].count == 0
        h["messages"] = map_for_init(GlobalMessage.all.desc('_id').limit(10))
        h["unread_count"] = 0
      else
        h["unread_count"] = h["messages"].count
      end
    end
    render :json => h
  end

  private
    def render_message(global_message)
      render partial: 'global_messages/message', locals: {message: global_message, current_user: current_user} 
    end

    def global_message_params
      params.require(:global_message).permit(:body)
    end
end