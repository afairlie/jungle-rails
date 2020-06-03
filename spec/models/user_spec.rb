require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do

    it 'should create a new user when password and confirmation provided' do
      @user = User.new(first_name: 'Steve', last_name: 'Cat', email: 'stephen_kitty@gmail.com', password: '12345', password_confirmation: '12345')
      @user.save

      expect(@user.password).to eq('12345')
    end

    it 'should not create a new user if password and password confirmation diff' do
      @user = User.new(first_name: 'Steve', last_name: 'Cat', email: 'stephen_kitty@gmail.com', password: '12345', password_confirmation: 'different_password')
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should not create a new user if password is blank' do
      @user = User.new(first_name: 'Steve', last_name: 'Cat', email: 'stephen_kitty@gmail.com', password: nil, password_confirmation: '12345')
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should not create a new user if email blank' do
      @user = User.new(first_name: 'Steve', last_name: 'Cat', email: nil , password: '12345', password_confirmation: '12345')
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should not create a new user if first name blank' do
      @user = User.new(first_name: nil, last_name: 'Cat', email: 'stephen_kitty@gmail.com' , password: '12345', password_confirmation: '12345')
      @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should not create a new user if last name blank' do
      @user = User.new(first_name: 'Steven', last_name: nil, email: 'stephen_kitty@gmail.com' , password: '12345', password_confirmation: '12345')
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should not create a new user if email already registered - not case sensitive' do
      @user1 = User.new(first_name: 'Steve', last_name: 'Cat', email: 'stephen_kitty@gmail.com', password: '12345', password_confirmation: '12345')
      @user1.save
      @user2 = User.new(first_name: 'Steve', last_name: 'Cat', email: 'STEPHEN_kitty@gmail.com', password: '12345', password_confirmation: '12345')
      @user2.save
      expect(@user2.errors.full_messages).to include('Email has already been taken')
    end

    it 'should not create a new user if password is too short' do
      @user = User.new(first_name: 'Steve', last_name: 'Cat', email: 'stephen_kitty@gmail.com', password: '123', password_confirmation: '123')
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'should return the user when credentials valid' do
      User.create(first_name: 'Steve', last_name: 'Cat', email: 'stephen_kitty@gmail.com', password: '12345', password_confirmation: '12345')
      user = User.authenticate_with_credentials('stephen_kitty@gmail.com', '12345')
      expect(user).to_not be_nil
      expect(user.first_name).to eq('Steve')
    end

    it 'should return user nil if wrong email' do
      User.create(first_name: 'Steve', last_name: 'Cat', email: 'stephen_kitty@gmail.com', password: '12345', password_confirmation: '12345')
      user = User.authenticate_with_credentials('wrongemail@gmail.com', '12345')
      expect(user).to be_nil
    end

    it 'should return user nil if wrong password' do
      User.create(first_name: 'Steve', last_name: 'Cat', email: 'stephen_kitty@gmail.com', password: '12345', password_confirmation: '12345')
      user = User.authenticate_with_credentials('stephen_kitty@gmail.com', 'wrongpass')
      expect(user).to be_nil
    end

    it 'should return the user when credentials valid case insensitive' do
      User.create(first_name: 'Steve', last_name: 'Cat', email: 'stephen_kitty@gmail.com', password: '12345', password_confirmation: '12345')
      user = User.authenticate_with_credentials('stephen_KITTY@gmail.com', '12345')
      expect(user).to_not be_nil
      expect(user.first_name).to eq('Steve')
    end

    it 'should return the user when credentials valid strip whitespace' do
      User.create(first_name: 'Steve', last_name: 'Cat', email: 'stephen_kitty@gmail.com', password: '12345', password_confirmation: '12345')
      user = User.authenticate_with_credentials(' stephen_kitty@gmail.com ', '12345')
      expect(user).to_not be_nil
      expect(user.first_name).to eq('Steve')
    end

  end
end
