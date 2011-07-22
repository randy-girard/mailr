class UserController < ApplicationController

  theme :theme_resolver
  layout "simple"

  def login
  end

  def logout
	reset_session
	flash[:notice] = t(:user_logged_out)
    redirect_to :action => "login"
  end

  def authenticate
	redirect_to :action => 'unknown'
	#redirect_to :controller => "messages", :action => "index"
  end

  def setup
  end

  def unknown
  end

end
