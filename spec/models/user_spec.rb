require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    before(:each) do
      @user = User.new(
        first_name: 'First',
        last_name: 'Last',
        email: 'brett.roberts@live.ca',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
    end

    it "should be created with a password and password_confirmation fields" do
      @user1 = User.new(
        first_name: 'First',
        last_name: 'Last',
        email: 'example@email.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user1).to be_valid
    end

    it 'should not be valid if password and password_confirmation do not match' do
      @user.password_confirmation = 'different_password'
      expect(@user).to_not be_valid
    end


    it "should have a unique email" do
      @user1 = User.new(
        first_name: 'First',
        last_name: 'Last',
        email: 'brett.roberts@live.ca',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user1).to_not be_valid
      expect(@user1.errors.full_messages).to include("Email has already been taken")
    end

    it 'should allow emails of different case' do
      @user.email = 'BRETT.ROBERTS@LIVE.CA'
      expect(@user).to be_valid
    end

    it 'should allow emails of different case' do
      @user.email = 'BReTt.RObErTS@Live.cA'
      expect(@user).to be_valid
    end

    it "should have a first name" do
      @user.first_name = nil
      expect(@user).to_not be_valid
    end

    it "should have a last name" do
      @user.last_name = nil
      expect(@user).to_not be_valid
    end

    it 'should have an email' do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it 'should have a password with at least 6 character' do
      @user.password = 'pass'
      expect(@user).to_not be_valid
    end

    it 'should have a password_confirmation' do
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
    end

    it 'should allow users to have whitespace around their email' do
      @user.email = 'brett.roberts@live.ca   '
      expect(@user).to be_valid
    end

    it 'should allow users to have whitespace around their email' do
      @user.email = '   brett.roberts@live.ca'
      expect(@user).to be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.new(
        first_name: 'First',
        last_name: 'Last',
        email: 'brett.roberts@live.ca',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
    end

    it 'should return the user if the email and password are correct' do
      expect(User.authenticate_with_credentials('brett.roberts@live.ca', 'password')).to eq(@user)
    end

    it 'should return nil if the email is incorrect' do
      expect(User.authenticate_with_credentials('bret.roberts@live.ca', 'password')).to eq(nil)
    end

    it 'should return nil if the password is incorrect' do
      expect(User.authenticate_with_credentials('brett.roberts@live.ca', 'passwor')).to eq(nil)
    end

  end

end
