# frozen_string_literal: true

# users migration
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.boolean :verified
      t.timestamps null: false
    end
  end
end
