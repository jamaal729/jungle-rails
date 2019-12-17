require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'should create a new user if all validations pass' do
      @user = User.new(name: "Name", email: "a@a.com", password: "pass", password_confirmation: "pass")
      @user.valid?
      expect(@user.errors).not_to include("can\'t be blank")
    end

    it 'should not create a user if email is not unique' do
      @user_1 = User.new(name: "Name", email: "test@test.COM", password: "pass", password_confirmation: "pass")
      @user_1.save
      @user_2 = User.new(name: "Name", email: "TEST@TEST.com", password: "pass", password_confirmation: "pass")
      @user_2.valid?
      expect(@user_2.errors[:email]).to include("has already been taken")
    end

    it 'should not create a user if name is blank' do
      @user = User.new(name: "", email: "a@a.com", password: "pass", password_confirmation: "pass")
      @user.valid?
      expect(@user.errors[:name]).to include("can\'t be blank")
    end

    it 'should not create a user if email is blank' do
      @user = User.new(name: "Name", email: "", password: "pass", password_confirmation: "pass")
      @user.valid?
      expect(@user.errors[:email]).to include("can\'t be blank")
    end

    it 'should not create a user if  passwords do not match' do
      @user = User.new(name: "Name", email: "a@a.com", password: "pass", password_confirmation: "past")
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include("doesn\'t match Password")
    end

    it 'should not create a user if password is blank' do
      @user = User.new(name: "Name", email: "a@a.com", password: "", password_confirmation: "")
      @user.valid?
      expect(@user.errors[:password_digest]).to include("can\'t be blank")
    end

    it 'should not create a user if password is not up to minimum length' do
      @user = User.new(name: "Name", email: "a@a.com", password: "pas", password_confirmation: "pas")
      @user.valid?
      expect(@user.errors[:password]).to include("is too short (minimum is 4 characters)")
    end

  end

  describe '.authenticate_with_credentials' do
    it 'should login user if credentials are correct' do
      @user = User.new(name: "Name", email: "a@a.com", password: "pass", password_confirmation: "pass")
      @user.save!
      expect(User.authenticate_with_credentials("a@a.com", "pass")).to be_present
    end

    it 'should not login user if password is wrong' do
      @user = User.new(name: "Name", email: "a@a.com", password: "pass", password_confirmation: "pass")
      @user.save!
      expect(User.authenticate_with_credentials("a@a.com", "past")).not_to be_present
    end  

    it 'should not login user if email is wrong' do
      @user = User.new(name: "Name", email: "a@a.com", password: "pass", password_confirmation: "pass")
      @user.save!
      expect(User.authenticate_with_credentials("b@b.com", "pass")).not_to be_present
    end

    it 'should login user even if email contains spaces' do
      @user = User.new(name: "Name", email: "a@a.com", password: "pass", password_confirmation: "pass")
      @user.save!
      expect(User.authenticate_with_credentials(" a@a . com ", "pass")).to be_present
    end

    it 'sshould login user even if email is typed with a different case' do
      @user = User.new(name: "Name", email: "a@a.com", password: "pass", password_confirmation: "pass")
      @user.save!
      expect(User.authenticate_with_credentials("A@A.COM", "pass")).to be_present
    end

  end


end
