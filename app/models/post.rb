class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  belongs_to :category
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  validates :category_id, presence: true

  def liked_by(user)
    self.likers.exists?(user.id)
  end

  def like(user)
    self.likes.find_by(user: user)
  end

  def number_of_likes()
    self.likes.count
  end
end
