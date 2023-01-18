class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments

  validates :name, presence: true
  validates :posts_counter, comparison: { greater_than_or_equal_to: 0 }

  def recent_three_posts
    Post.where(author_id: self.id).order(updated_at: :desc).limit(3)
  end
end
