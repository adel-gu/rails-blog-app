require 'rails_helper'

# I can see the user's profile picture.
# I can see the user's username.
# I can see the number of posts the user has written.
# I can see the user's bio.
# I can see the user's first 3 posts.
# I can see a button that lets me view all of a user's posts.
# When I click a user's post, it redirects me to that post's show page.
# When I click to see all posts, it redirects me to the user's post's index page.

RSpec.describe 'posts/show.html.erb', type: :system do
  subject { User.new(name: 'test', photo: "http://google.com", bio: "Programmer") }
  before{ subject.save }

  describe 'index page' do
    it 'shows the right content' do
      Post.create(author: subject, title: 'Hello0', text: 'This is my first post')
      post_1 = Post.create(author: subject, title: 'Hello1', text: 'This is my second post')
      Post.create(author: subject, title: 'Hello2', text: 'This is my third post')
      Post.create(author: subject, title: 'Hello3', text: 'This is my fourth post')

      visit user_path(subject)
      expect(page).to have_xpath("//img[@src = 'http://google.com' and @alt='test photo']")
      expect(page).to have_content('test')
      expect(page).to have_content('Number of posts: 4')
      expect(page).to have_content('Programmer')
      expect(page).to have_content('See all posts')

      subject.recent_three_posts.each do |post|
        expect(page).to have_content(post.title)
        expect(page).to have_content(post.text)
      end

      # click_link("Hello1")
      # sleep(5)
      # expect(page).to have_current_path(user_post_path(subject, post_1))

      visit user_path(subject)
      click_link("See all posts")
      sleep(5)
      expect(page).to have_current_path(user_posts_path(subject))
    end
  end
end
