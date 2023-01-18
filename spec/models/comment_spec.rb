require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.create(name: 'author')
  post = Post.create(author: user, title: 'Hello', text: 'This is my first post')
  subject { Comment.new(author: user, post:) }

  context 'testing comments_counter for non saved post' do
    after { subject.save }
    it 'should be 0' do
      expect(Post.find(post.id).comments_counter).to be 0
    end
  end

  context 'testing comments_counter for a saved post' do
    before { subject.save }
    it 'should be 1' do
      expect(Post.find(post.id).comments_counter).to be 1
    end
  end
end
