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
  end

end
