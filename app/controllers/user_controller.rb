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
		user = User.find_by_email(params[:user][:email])
		if user.nil?
			redirect_to :action => 'unknown' ,:email=> params[:user][:email]
		else
			auten = true
			if auten == true
				session[:user_id] = user.id
				user.set_cached_password(session,params[:user][:password])

				if session["return_to"]
					redirect_to(session["return_to"])
					session["return_to"] = nil
				else
					redirect_to :controller=> 'messages', :action=> 'refresh'
				end


			else
				flash[:error] = t(:login_failure)
				redirect_to :action => 'login'
			end
		end
	end

	def loginfailure
	end

	def setup
		@user = User.new
		@server = Server.new
	end

	def unknown
	end

	def create

		@user = User.new
		@user.email = params["user_email"]
		@user.first_name = params["user_first_name"]
		@user.last_name = params["user_last_name"]

        @server = Server.new
		@server.name = params["server_name"]

		if @user.valid? and @server.valid?
			@user.save
			@server.user_id = @user.id
			@server.save
			Prefs.create_default(@user.id)
			flash[:notice] = t(:setup_done)
			redirect_to :action => 'login'
		else
			render "setup"
		end
	end

end