require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(name: 'author')
  subject { Post.new(author: user, title: 'Hello', text: 'This is my first post') }

  before { subject.save }

  context 'testing validation' do
    it 'for title should be invalid with nil value' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'for title should be valid with a valid value' do
      expect(subject).to be_valid
    end

    it 'for title should be valid for not exceeding 250 characters' do
      expect(subject).to be_valid
    end

    it 'for title should be invalid for exceeding 250 characters' do
      subject.title = 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec.'
      expect(subject).to_not be_valid
    end

    it 'for comments_counter should be invalid for negative values' do
      subject.comments_counter = -10
      expect(subject).to_not be_valid
    end

    it 'for comments_counter should be valid for non negative values' do
      expect(subject).to be_valid
    end

    it 'for likes_counter should be invalid for negative values' do
      subject.likes_counter = -10
      expect(subject).to_not be_valid
    end

    it 'for likes_counter should be valid for non negative values' do
      expect(subject).to be_valid
    end
  end

  context 'When testing update_posts_counter' do
    before { subject.save }

    it 'should increment posts_counter in user' do
      expect(User.find(user.id).posts_counter).to_not eq 0
    end
  end

  context 'When testing recent_five_comments' do
    before { 10.times { Comment.create(post: subject, author: user, text: 'Hi Tom!') } }

    it 'recent_five_comments should return array of length 5' do
      expect(subject.recent_five_comments.length).to eq 5
    end
  end
end
