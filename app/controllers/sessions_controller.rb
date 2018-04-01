class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])#authenticate method is available by "has_secure_password" on User model
    # Success
      log_in user # method in sessions_helper (session[:user_id] = user.id)
      # params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to root_url
    else
      # Failure
      flash.now[:danger] = 'Invalid email/password'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in? #delete the session of login user
    redirect_to root_url
  end
  
end
