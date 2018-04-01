require 'rails_helper'

describe TasksController do
  
  #ログイン無ユーザ

  describe 'anonymous access' do
    describe 'GET #show' do
      it 'requires login' do
        task = create(:task)
        get :show, params: { id: task.id}
        expect(response).to redirect_to login_url
      end
    end
    describe 'GET #index' do
      it 'requires login' do
        get :index
        expect(response).to redirect_to login_url
      end
    end

    describe 'GET #new' do
      it 'requires login' do
        get :new
        expect(response).to redirect_to login_url
      end
    end
    
    
    describe 'POST #create' do
      it 'requires login' do
        #task = create(:task)
        post :create, params: {task: attributes_for(:task)}

        expect(response).to redirect_to login_url
      end
    end
    

    describe 'GET #edit' do
      it 'requires login' do
        task = create(:task)
        get :edit, params: { id: task.id}
        expect(response).to redirect_to login_url
      end
    end

    describe 'POST #update' do
    end
  end
  
  #ログイン有、非所有者、非admin
  describe 'logged in user'do
    before :each do
      user = create(:user)
      session[:user_id] = user.id    
    end
  end
  
  #ログイン有、所有者、非admin
  #ログイン有、非所有者、admin
  
  xdescribe 'GET #show' do
    
    
    it "assigns the requested task to @task" do 
      
      task = create(:task)
      get :show, params: { id: task.id}
      expect(assigns(:task)).to eq task
      #assignsメソッドはコントローラーのインスタンス変数をテストするメソッド
      #引数にインスタンス変数をシンボル型で渡す
      #indexメソッド内の@taskが、作成した変数taskと一致しているかを確認
    end
    
    

    
    
  end
  
  xdescribe 'GET #index' do
   

    it "populates an array of all tasks" do
      user1 = create(:user)
      subject1 = create(:subject,user:user1)
      task1 = create(:task,subject:subject1)
      task2 = create(:task,subject:subject1)
      
      user2 = create(:user, lastname:'Tom',email:'foobar@hoge.com')
      subject2 = create(:subject,user:user2)
      task3 = create(:task,subject:subject2)
      get :index
      p task1
      # expect(assigns(:tasks)).to match_array([task1, task2]) #correct
      expect(assigns(:tasks)).to match_array([task1, task2,task3])
    end
    
    it "renders the :index template" do
    get :index
      expect(response).to render_template :index
    end
  end
  
  describe 'GET #new' 
  
  describe 'GET #edit' 
  
  describe 'POST #create' 
  
  describe 'PATCH #update' 
  
  describe 'DELETE #destroy'
  
end