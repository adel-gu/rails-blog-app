class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments
  after_initialize :set_posts_counter_default

  validates :name, presence: true
  validates :posts_counter, numericality: true, comparison: { greater_than_or_equal_to: 0 }

  def recent_three_posts
    Post.where(author: self).order(updated_at: :desc).limit(3)
  end

  private
  def set_posts_counter_default
    self.posts_counter = 0 unless self.posts_counter
  end
end
