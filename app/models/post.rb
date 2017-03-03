class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :category
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  validates :category_id, presence: true
end
