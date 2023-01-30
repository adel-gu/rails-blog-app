class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :likes
  after_save :update_posts_counter
  after_initialize :set_comments_and_likes_counters

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, :likes_counter, numericality: true, comparison: { greater_than_or_equal_to: 0 }

  def update_posts_counter
    User.find(author_id).increment!(:posts_counter)
  end

  # A method which returns the 5 most recent comments for a given post.
  def recent_five_comments
    comments.includes(:author).order(updated_at: :desc).limit(5)
  end

  private

  def set_comments_and_likes_counters
    self.likes_counter = 0 unless likes_counter
    self.comments_counter = 0 unless comments_counter
  end
end
