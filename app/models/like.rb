class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def update_likes_counter
    Post.find(self.post_id).increment!(:likes_counter)
  end
end
