class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  def update_posts_counter
    User.find(self.user_id).increment!(:posts_counter)
  end
end
