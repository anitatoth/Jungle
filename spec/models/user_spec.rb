require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "should save if all fields are valid" do
      @user = User.new(first_name:"Buffy", last_name:"Summers", email: "slayer@gmail.com", password: "1234", password_confirmation: "1234") 
      expect(@user).to be_valid
    end

    it "should not be valid without an email" do
      @user = User.new(first_name:"Buffy", last_name:"Summers", email: nil, password: "1234", password_confirmation: "1234")
      expect(@user).to_not be_valid 

    end

    it "should not be valid without a name" do
      @user = User.new(first_name: nil, last_name: nil, email: "slayer@gmail.com", password: "1234", password_confirmation: "1234" ) 
      expect(@user).to_not be_valid
    end

    it "should not be valid without a password" do
      @user = User.new(first_name:"Buffy", last_name:"Summers", email: "slayer@gmail.com", password: nil, password_confirmation: nil ) 
      expect(@user).to_not be_valid
    end

    it "should not be valid if password is < 3 characters" do
      @user = User.new(first_name:"Buffy", last_name:"Summers", email: "slayer@gmail.com", password: "1", password_confirmation: "1")
      expect(@user).to_not be_valid
    end

    it "should not be valid unless password and password_confirmation match" do
      @user = User.new(first_name:"Buffy", last_name:"Summers", email: "slayer@gmail.com", password: "1234", password_confirmation: "1111" ) 
      expect(@user).to_not be_valid
    end

    it "should not be valid if email already exists but not be case sensitive" do
      @user1 = User.create(first_name:"Buffy", last_name:"Summers", email: "slayer@gmail.com", password: "1234", password_confirmation: "1234" ) 
      @user2 = User.create(first_name:"Willow", last_name:"Rosenberg", email: "SLAYER@gmail.com", password: "1234", password_confirmation: "1234" ) 
      expect(@user2).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
  end

end
