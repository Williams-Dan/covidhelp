# frozen_string_literal: true

# Post model
class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
end
