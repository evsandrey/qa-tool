class StaticController < ApplicationController
  def index
    
  end

  def faq
  end

  def reports
  end
  
  def profiles
    @q = User.ransack(params[:q])
    @q.sorts = 'created_at desc' if @q.sorts.empty?
    @users = @q.result.page params[:page]
  end
  
end
