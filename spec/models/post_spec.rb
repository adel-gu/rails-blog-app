require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(author: User.new("author"), title: 'Hello', text: 'This is my first post') }

  before { subject.save }

  context "testing validation" do
    it "for title should be invalid with nil value" do
      subject.title = nil
      expect(subject).to_not be_valid
    end
  end
end