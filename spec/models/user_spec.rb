require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    before(:each) do
      @user = User.create(name: 'foo', email: 'foo@bar.com', password: 'password', password_confirmation: 'password')
      @user2 = User.create(name: 'test', email: 'foo@bar.com', password: 'password', password_confirmation: 'password')
    end

    it "Should create new user" do
      @user.valid?
      expect(@user.errors.full_messages).to include()
    end

    it "Password and password_confirmation should be equal" do
      @user.password_confirmation = "passwd"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "Email should be unique" do
      user = User.create(name: 'foo', email: 'foo@bar.com', password: 'password', password_confirmation: 'password')
      user2 = User.create(name: 'test', email: 'FOO@bar.com', password: 'password', password_confirmation: 'password')
      user2.valid?
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it "Password length must be at least 6 chars" do
      user = User.create(name: 'foo', email: 'foo@bar.com', password: 'pass', password_confirmation: 'pass')
      user.valid?
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end
  
  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.create(name: 'foo', email: 'foo@bar.com', password: 'password', password_confirmation: 'password')
    end

    it "Email is case insensitive on login form" do
      expect(User.authenticate_with_credentials("FOO@bar.com", "password")).to be_truthy
    end

    it "Removes whitespace around email" do
      expect(User.authenticate_with_credentials("  FOO@bar.com  ", "password")).to be_truthy
    end
  end
end
