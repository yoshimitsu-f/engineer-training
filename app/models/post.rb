class Post < ApplicationRecord
  has_many :comments
  validates :content, {presence: true}


end
