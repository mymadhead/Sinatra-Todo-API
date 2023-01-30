# frozen_string_literal: true

class Todo < ActiveRecord::Base
  belongs_to :user

  has_many :tasks, dependent: :delete_all

  validates :title, presence: true
end
