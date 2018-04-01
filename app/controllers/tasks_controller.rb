class TasksController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,only: [:show,:edit,:update,:destroy]


  def index
    if current_user && current_user.admin
      @tasks = Task.order('registration_date DESC')
    else
      @tasks = Task.joins(:subject => :user).where(:users => {:id => current_user })
      # @tasks = Task.where('subject.user.id = ?', current_user)
      # (subject.user.id: current_user)
      
      # Task.all(:include => :subject, 
        # :conditions => ["subjects.user_id = ?", current_user.id ]).order('registration_date DESC')
        # User.where(kind: 1)
    end
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success]="Task is created successfully"
      redirect_to @task
    else
      render 'new'
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(task_params)
      flash[:success]="Task is updated successfully"
      redirect_to @task
    else
      render 'edit'
    end
  end
  
  def destroy
    Task.find(params[:id]).destroy
    flash[:success] = "Task deleted"
    redirect_to tasks_path
  end
  
  def toggle
    
    @task = Task.find(params[:task_id])
    if @task.done
      @task.update_attribute(:done, false)
      @status = "\u2610" #BALLOT BOX
    else
      @task.update_attribute(:done, true)
      @status = "\u2611" #BALLOT BOX WITH CHECK
    end
    @element = "status-" + @task.id.to_s
    # status-<%=t.id%>
    respond_to do |format|
      format.html
      format.js
    end
    
  end
  
  private 
    def task_params
      params.require(:task).permit(
        :title,:description,:done,:registration_date,
        :first_reminder_date,:second_reminder_date,:third_reminder_date,:subject_id)
    end
    
    
    #check whether the current user has logged in
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    def correct_user
      unless current_user.admin?
        @task = Task.find(params[:id])
        user_id = Subject.find(@task.subject_id).user_id
        unless current_user.id == user_id
          flash[:danger] = "Only owner or admin user can modify this record."
          redirect_to tasks_path
        end
      end
    end
    
  
  
end