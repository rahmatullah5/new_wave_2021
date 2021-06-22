# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_secure_password :recovery_password, validations: false

  has_many :posts
  has_many :comments

  validates :email, :password, :name, presence: true
  validates :email, uniqueness: true
end
