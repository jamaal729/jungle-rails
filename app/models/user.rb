class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 4 }
  validates :password_confirmation, length: { minimum: 4 }

  def authenticate_with_credentials (email, password)
    #return instance of user if authenticated
  end
end