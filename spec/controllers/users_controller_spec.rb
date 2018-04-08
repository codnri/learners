require 'rails_helper'

describe UsersController do

  
  # include  ActionView::Helpers::SessionsHelper
  describe "login with valid user" do
    before do
        @user = create(:user)
        session[:user_id] = @user.id
     end
    
    describe 'GET #show' do
      
      it "assigns the requested user to @user" do 
        get :show, params: {id: @user}
        expect(assigns(:user)).to eq @user  #check @user variable in user controller whether it has the value same with @user(=created in spec)
      end
      
      it "renders the show template" do
        # user = create(:user)
        get :show, params: {id: @user}
        expect(response).to render_template :show
      end
      
    end
    
    describe "GET #new" 
    
    describe "GET #index" do 
      it "assigns the requested users to @users" do 
        # user1 = create(:user, email: "user1@test.com")
        user2 = create(:user, email: "user2@test.com")
        user_array = [@user,user2]
        get :index
        expect(assigns(:users)).to match_array(user_array) 
      end
      
      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
      
    end
    describe "GET #edit" do
        it "assigns the requested user to @user" do 
        # user = create(:user)
        get :edit, params: {id: @user}
        expect(assigns(:user)).to eq @user  
      end
      
      it "renders the show template" do
        # user = create(:user)
        get :edit, params: {id: @user}
        expect(response).to render_template :edit
      end
    end
  end
  
  
  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new user in the database" do
        expect{
          post :create, params: {user: attributes_for(:user)}
        }.to change(User,:count).by(1)
      end
      it "redirects to task#index" do
        post :create, params: {user: attributes_for(:user)}
        expect(response).to redirect_to root_path
      end
    end
    
    
    context "with invalid attributes" do
      it "does not save the new user in the database" do
        expect{
          post :create, params: {user: attributes_for(:invalid_user)}
        }.not_to change(User,:count)
      end
      it "re-renders the :new template" do
        post :create, params: {user: attributes_for(:invalid_user)}
        expect(response).to render_template :new
      end
    end
    
  end
  
  describe "PATCH #update" do
  
    before :each do
      @user = create(:user) # firstname "John" lastname "White"
      session[:user_id] = @user.id
    end
  
    context "valid attributes" do

      it "locates the requested @contact" do
        patch :update, params: {id: @user, user: attributes_for(:user)}
        expect(assigns(:user)).to eq(@user)
      end
      
      it "changes @user's attributes" do
        patch :update, params: { id: @user, user: attributes_for(:user,
        firstname: 'Foo',
        lastname: 'Bar') }
        @user.reload
        expect(@user.firstname).to eq('Foo')
        expect(@user.lastname).to eq('Bar')
      end
      
      # 更新した連絡先のページへリダイレクトすること
      it "redirects to the updated user" do
        patch :update, params: {id: @user, user: attributes_for(:user)}
        expect(response).to redirect_to @user
      end
    end


    context "with invalid attributes" do
      # 連絡先の属性を変更しないこと
      it "does not change the user's attributes" do
        patch :update, params: { 
          id: @user,
          user: attributes_for(:user,firstname: "Foo", lastname: nil)
        }
        @user.reload
        expect(@user.firstname).not_to eq("Foo")
        expect(@user.lastname).to eq("White")
      end
      
      # edit テンプレートを再表示すること
      it "re-renders the :edit template" do
        patch :update, params: { 
          id: @user,
          user: attributes_for(:invalid_user)
        }
        expect(response).to render_template :edit
        
      end
    end
  end
  
  describe 'DELETE #destroy' do
    before :each do
      @user = create(:user)
      session[:user_id] = @user.id
    end
    
    # 連絡先を削除すること
    it "deletes the user" do
      expect{
      delete :destroy, params: {id: @user}
       }.to change(User,:count).by(-1)
    end
    
    # contacts#index にリダイレクトすること
    it "redirects to contacts#index" do
      delete :destroy, params: {id: @user}
      expect(response).to redirect_to users_url
    end
  end
  
end
