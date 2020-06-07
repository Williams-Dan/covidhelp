# frozen_string_literal: true

require 'dotenv'
Dotenv.load

#:nodoc:
class JsonWebToken
  APP_SECRET = ENV['SESSION_SECRET']

  def self.encode(payload, exp = 1.hour.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, APP_SECRET)
  end

  def self.decode(token)
    body = JWT.decode(token, APP_SECRET)[0]
    HashWithIndifferentAccess.new body
  rescue JWT::ExpiredSignature
    raise ExceptionHandler::ExpiredToken, 'Expired token'
  rescue JWT::DecodeError
    raise ExceptionHandler::InvalidToken, 'Invalid token'
  end
end
