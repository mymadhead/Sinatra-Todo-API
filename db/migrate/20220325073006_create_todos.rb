# frozen_string_literal: true

class CreateTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.boolean :status, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
