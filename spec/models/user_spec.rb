require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Adel') }
  before { subject.save }

  context 'When testing validations' do
    it 'User is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'User is a valid with a name' do
      expect(subject).to be_valid
    end

    it 'User is a not valid with a negative posts_counter' do
      subject.posts_counter = -10
      expect(subject).to_not be_valid
    end

    it 'User is valid with a positive posts_counter' do
      expect(subject).to be_valid
    end
  end

  context 'When testing behavior' do
    before { 5.times { Post.create(author: subject, title: 'Hello', text: 'This is my first post') } }

    it 'lists the most 3 recent posts' do
      expect(subject.recent_three_posts.length).to eq 3
    end
  end
end
