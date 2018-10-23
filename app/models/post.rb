# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :user
  validates :content, presence: true
  validates :user_id, presence: true
end
