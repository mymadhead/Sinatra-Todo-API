# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :body
      t.boolean :completed, default: false
      t.references :todo, foreign_key: true

      t.timestamps
    end
  end
end
