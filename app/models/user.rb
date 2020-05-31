# frozen_string_literal: true

require 'bcrypt'

# User model
class User < ActiveRecord::Base
  has_many :posts

  include BCrypt
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_hash, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
