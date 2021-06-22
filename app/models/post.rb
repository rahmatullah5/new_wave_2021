# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title, :content, presence: true
end
