class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  after_initialize :set_posts_counter_default

  validates :name, presence: true
  validates :posts_counter, numericality: true, comparison: { greater_than_or_equal_to: 0 }

  def recent_three_posts
    Post.where(author: self).order(updated_at: :desc).limit(3)
  end

  private

  def set_posts_counter_default
    self.posts_counter = 0 unless posts_counter
  end
end
