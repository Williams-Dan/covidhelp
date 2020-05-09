# frozen_string_literal: true

# User model
class User < ActiveRecord::Base
  before_create :hash_password

  private

  def hash_password
    puts("TODO: Hash password '#{password}'")
  end
end
