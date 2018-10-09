# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments
  belongs_to :user
  validates :content, presence: true
  validates :user_id, presence: true
end
