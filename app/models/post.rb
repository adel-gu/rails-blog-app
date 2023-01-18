class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :likes
  after_save :update_posts_counter

  validates :title, presence: true, length: { maximum: 250 }

  def update_posts_counter
    User.find(self.author_id).increment!(:posts_counter)
  end

  # A method which returns the 5 most recent comments for a given post.
  def recent_five_comments
    Comment.where(post_id: self.id).order(updated_at: :desc).limit(5)
  end
end
