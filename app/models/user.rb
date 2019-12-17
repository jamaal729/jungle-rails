class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 4 }
  validates :password_confirmation, length: { minimum: 4 }
  validates :password_digest, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.gsub(' ', '').downcase)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end