# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :user
  validates :body, presence: true, length: { maximum: 30 }
  validates :user_id, presence: true
end
