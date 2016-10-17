class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :chat_init, :set_timezone
  
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end
  
  
  def chat_init
    # For new messages
    @global_message = GlobalMessage.new
  end
  
  def set_timezone
    tz = current_user ? current_user.time_zone : nil
    Time.zone = tz || ActiveSupport::TimeZone["UTC"]
  end
  
  def log_warning(module_name, message)
    log = Log.new()
    log.module_name = module_name
    log.level = 'W'
    log.message = message
    log.save
  end
  
  def log_debug(module_name, message)
    log = Log.new()
    log.module_name = module_name
    log.level = 'D'
    log.message = message
    log.save
  end
  
  def log_access(module_name, message)
    log = Log.new()
    log.module_name = module_name
    log.level = 'A'
    log.message = message
    log.save
  end

end
