# frozen_string_literal: true

class Task < ActiveRecord::Base
  belongs_to :todo
  has_one :user, through: :todo

  validates :body, presence: true
  validates :todo_id, presence: true
end
