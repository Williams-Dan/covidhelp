# frozen_string_literal: true

require 'bcrypt'
require './lib/email'
require './lib/json_web_token'

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

  def send_verify_email
    # TODO: Fix from email and message body
    token = JsonWebToken.encode(user_id: id)
    url = "http://209.97.132.224/verify?token=#{token}"
    Email.send(
      'noreply@covidhelp.scot',
      email,
      'Covid Help: Verify Email',
      "Click here to verify: #{url}",
      "Click here to verify: #{url}"
    )
  end

  def self.verify_from_token(token)
    decoded = JsonWebToken.decode(token)

    if (user = find(decoded[:user_id]))
      user.update!(verified: true)
      true
    else
      false
    end
  end
end
