require 'rails_helper'

describe User do
  it "is valid with all attributes" do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it "is invalid without a firstname" do
    user = build(:user, firstname: nil )
    user.valid?
    expect(user.errors[:firstname]).to include("can't be blank")
  end
  
  it "is invalid with more than 50 characters firstname" do
    user = build(:user, firstname: 'a'*51 )
    user.valid?
    expect(user.errors[:firstname]).to include("is too long (maximum is 50 characters)")
  end
  
  it "is invalid without a lastname" do
    user = build(:user, lastname: nil )
    user.valid?
    expect(user.errors[:lastname]).to include("can't be blank")
  end
  
  it "is invalid with more than 50 characters lastname" do
    user = build(:user, lastname: 'a'*51 )
    user.valid?
    expect(user.errors[:lastname]).to include("is too long (maximum is 50 characters)")
  end
  
    
  it "is invalid without a email" do
    user = build(:user, email: nil )
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  
  it "is invalid with wrong email format" do
    user = build(:user, email: "foo@test." )
    user.valid?
    expect(user.errors[:email]).to include("is invalid")
  end
  
  it "is invalid with more than 255 characters email" do
    user = build(:user, email: 'a'*250+"@bb.ca" )
    user.valid?
    expect(user.errors[:email]).to include("is too long (maximum is 255 characters)")
  end
  
  it "is invalid with duplicated email" do
    user1 = create(:user,email:"dup@test.com")
    user2 = build(:user,email:"dup@test.com")
    user2.valid?
    expect(user2.errors[:email]).to include("has already been taken")
  end
  
  it "is invalid with a blank password" do
    user = build(:user, password: " "*7,password_confirmation: " "*7)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end
  
  it "is invalid with nil password" do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end
  
  it "is invalid with a difference between password and password_confirmation" do
    user = build(:user, password: "password",password_confirmation:"foobar" )
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end
  
  it "is invalid with a less than 6 characters password" do
    user = build(:user, password: "foo",password_confirmation: "foo" )
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end
 
  
end