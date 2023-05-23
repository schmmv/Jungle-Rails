require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'successfully creates new user with all fields' do
      @user = User.create(
        password: '123456',
        password_confirmation: '123456',
        email: 'test@test.com',
        name: 'John' 
      )
      # puts @user.inspect
      expect(@user).to be_valid
    end

    it 'is not created without a password-confirmation field' do
      @user = User.create(
        password: '123456',
        password_confirmation: nil,
        email: 'test@test.com',
        name: 'John' 
      )
      # puts @user.errors.full_messages
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'is not created without a password field' do
      @user = User.create(
        password: nil,
        password_confirmation: nil,
        email: 'test@test.com',
        name: 'John' 
      )
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is not created without a name' do
      @user = User.create(
        password: '123456',
        password_confirmation: '123456',
        email: 'test@test.com',
        name: nil 
      )
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not created without an email' do
      @user = User.create(
        password: '123456',
        password_confirmation: '123456',
        email: nil,
        name: 'John' 
      )
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'is not created if password and password-confirmation do not match' do
        @user = User.create(
          password: '123456',
          password_confirmation: '098765',
          email: 'test@test.com',
          name: 'John' 
        )
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is not created when email is not unique (case insensitive)' do
        # create two users with same email
      @user1 = User.create(
        password: '123456',
        password_confirmation: '123456',
        email: 'test@test.com',
        name: 'Bob'
      )

      @user2 = User.create(
        password: '123456',
        password_confirmation: '123456',
        email: 'test@TEST.com',
        name: 'Jim'
      )
   
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
   
    it 'is not created when password length is less than 6' do
      @user = User.create(
        password: '12345',
        password_confirmation: '123456',
        email: 'test@test.com',
        name: nil 
      )
      # puts @user.errors.full_messages
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'authenticates with valid credentials' do 
      @user = User.create(
        password: '123456',
        password_confirmation: '123456',
        email: 'test@test.com',
        name: 'Jim'
      )
      expect(User.authenticate_with_credentials('test@test.com', '123456')).to eq(@user)
    end

    it 'authenticates with insensitive email case' do
      @user = User.create(
        password: '123456',
        password_confirmation: '123456',
        email: 'test@test.com',
        name: 'Jim'
      )
      expect(User.authenticate_with_credentials('test@TEST.com', '123456')).to eq(@user)
    end

    it 'authenticates with leading and trailing spaces' do
      @user = User.create(
        password: '123456',
        password_confirmation: '123456',
        email: 'test@test.com',
        name: 'Jim'
      )
      expect(User.authenticate_with_credentials(' test@TEST.com ', '123456')).to eq(@user)
    end

    it "doesn't authenticate if password is wrong" do
      @user = User.create(
        password: '123456',
        password_confirmation: '123456',
        email: 'test@test.com',
        name: 'Jim'
      )
      expect(User.authenticate_with_credentials('test@test.com', '654321')).to be_nil
    end
  end
end