require 'rails_helper'

RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"

  it 'should not create a user without an email' do
    @user = User.new(name: "Jamaal", password: "pass", password_confirmation: "pass")
    @user.valid?
    expect(@user.errors[:email]).to include("can\'t be blank")
  end

  it 'should not accept a password which is too short' do
    @user = User.new(name: "Jamaal", email: "aaa@aaa.com", password: "pa", password_confirmation: "pa")
    @user.valid?
    expect(@user.errors[:password]).to include(/is too short/)
  end


  
end




