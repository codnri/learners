module SessionsHelper
  
  #create a session for the login user
  def log_in(user)
    session[:user_id] = user.id
    # p "-------"
    # p session[:user_id]
  end
  
  
  def current_user?(user)
    user == current_user
  end
  
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    end
  end
  
  def logged_in?
    # p "-------"
    # p @current_user
    
    !current_user.nil?
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
end
