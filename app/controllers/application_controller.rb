class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_filter :chat_init, :set_timezone
  prepend_before_filter :get_auth_token
  
  # before_action :authenticate_user!
  
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
  
  def log_warning(level,module_name, message)
    log = Log.new()
    log.module_name = module_name
    log.ip_address = request.remote_ip  if !request.remote_ip.blank?
    log.level = 'W'
    log.user = current_user if !current_user.nil? 
    log.message = message
    log.save
  end
  
  def log_debug(module_name, message)
    log = Log.new()
    log.module_name = module_name
    log.ip_address = request.remote_ip  if !request.remote_ip.blank?
    log.level = 'D'
    log.user = current_user if !current_user.nil? 
    log.message = message
    log.save
  end
  
  def log_access(module_name, message)
    log = Log.new()
    log.module_name = module_name
    log.ip_address = request.remote_ip  if !request.remote_ip.blank?
    log.level = 'A'
    log.user = current_user if !current_user.nil? 
    log.message = message
    log.save
  end
  
  def log_error(module_name, message)
    log = Log.new()
    log.module_name = module_name
    log.ip_address = request.remote_ip  if !request.remote_ip.blank?
    log.level = 'E'
    log.user = current_user if !current_user.nil? 
    log.message = message
    log.save
  end
  
  private
    def get_auth_token
    if auth_token = params[:auth_token].blank? && request.headers["X-AUTH-TOKEN"]
      params[:auth_token] = auth_token
    end
  
  
end
  
  
end
