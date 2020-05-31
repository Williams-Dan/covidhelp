# frozen_string_literal: true

# Post model
class Post < ActiveRecord::Base
  belongs_to :user
end
