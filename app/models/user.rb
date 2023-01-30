# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :todos, dependent: :destroy
  has_many :tasks, through: :todos
  has_secure_password
  EMAIL_REGEX = /\A[a-z\d._%+-]+@[a-z\d.-]+\.[a-z]{2,4}\z/i

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
end
