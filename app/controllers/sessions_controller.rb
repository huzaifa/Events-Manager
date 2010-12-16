class SessionsController < ApplicationController

  def new
    @title = "Sign in"
  end

  def create
		user = User.authenticate(params[:session][:uni],
                             params[:session][:ppassword])
    if user.nil?
      flash.now[:error] = "Invalid uni/password combination."
      @title = "Sign in"
      render 'new'
    else
      sign_in user
			redirect_back_or user_path(user)
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
