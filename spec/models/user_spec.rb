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
    describe '.authenticate_with_credentials' do
      it "should return user with valid credentials" do
        @user = User.create(first_name:"Buffy", last_name:"Summers", email: "slayer@gmail.com", password: "1234", password_confirmation: "1234") 
        
        expect(User.authenticate_with_credentials('slayer@gmail.com', '1234')).not_to be(nil)
      end

      it "should return nil if not  authenticated" do
        @user = User.create(first_name:"Buffy", last_name:"Summers", email: "slayer@gmail.com", password: "1234", password_confirmation: "1234") 
        
        expect(User.authenticate_with_credentials('slayer@gmail.com', '5678')).to be(nil)
      end

      it 'should authenticate even if spaces before and after email' do
        @user = User.create(first_name:"Buffy", last_name:"Summers", email: "slayer@gmail.com", password: "1234", password_confirmation: "1234") 
        
       expect(User.authenticate_with_credentials('  slayer@gmail.com  ', '1234')).not_to be(nil)
      end

      it 'should pass even if email is uppercase or lowercase' do
        @user = User.create(first_name:"Buffy", last_name:"Summers", email: "slayer@gmail.com", password: "1234", password_confirmation: "1234") 
        
        expect(User.authenticate_with_credentials('SLAyer@gmail.com', '1234')).not_to be(nil)
      end
    end
  
  end

end
