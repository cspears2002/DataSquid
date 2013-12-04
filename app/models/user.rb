require 'bcrypt'

class User < ActiveRecord::Base
  has_many :graphs

  before_save :hash_password

  attr_accessor :password

  def authenticate(password)
    # Is the salted password the same as the hashed password?
    self.hashed_password == BCrypt::Engine.hash_secret(password, self.salt)
  end

  private

  def hash_password
    if password.present?
      # Salt and save the password
      self.salt = BCrypt::Engine.generate_salt
      self.hashed_password = BCrypt::Engine.hash_secret(password, self.salt)

      # Reset password and password confirmation
      password = password_confirmation = nil
    end
  end

end
