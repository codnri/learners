class SubjectsController < ApplicationController

  before_action :logged_in_user

  def show
    @subject = Subject.find(params[:id])
    @tasks = Task.where(subject_id: @subject.id)
  end
  def edit
    @subject = Subject.find(params[:id])
  end
  
  def update
    @subject = Subject.find(params[:id])
    if @subject.update(subject_params)
         flash[:notice] = "Subject has been updated"
      redirect_to subject_path
    else
      flash[:alert] = "Subject has not been updated"
      render :edit
    end
    
  end
  
  def destory
  end
  private 
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    def subject_params
      params.require(:subject).permit(:name)
      # params.require(:exercise).permit(:duration_in_min, :workout, :workout_date, :user_id)
      
    end
  
    
end
