class UsersController < ApplicationController

  before_action :check_logged_in_user, except: [:new,:create]
  # before_action :check_current_user,   only: [:edit, :update]
  # before_action :check_admin_user,     only: :destroy


  def show
    @user = User.find(params[:id])
  end
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user #create session
      flash[:success]="Welcome to Learners!!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success]="profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end  
  
  private 
    def user_params
      params.require(:user).permit(
        :firstname,:lastname,:email,
        :password,:password_confirmation,:admin
        )
    end


    def check_logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    def check_current_user
      # GET   /users/:id/edit
      # PATCH /users/:id
      @user = User.find(params[:id])
      
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "Only admin user can edit other users or delete users"
        redirect_to(users_url) 
      end
    end
    
    def check_admin_user
      unless current_user.admin?
        flash[:danger] = "Only admin user can edit other users or delete users"
        redirect_to(users_url) 
      end
    end
  
end
