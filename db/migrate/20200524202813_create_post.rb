# frozen_string_literal: true

# post migration
class CreatePost < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.timestamps null: false
      t.references :user, null: false, foreign_key: true
    end
  end
end
