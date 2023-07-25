require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  before do
    @user = User.create(
      name: 'John Doe',
      photo: 'path/to/user_profile_picture.jpg',
      bio: 'A short bio for John Doe'
    )
    
    visit user_path(@user)
  end

  it 'displays the user profile picture' do
    expect(page).to have_css('img[alt="userPhoto"]')
  end

  it 'displays the user username' do
    expect(page).to have_content(@user.name)
  end

  it 'displays the number of posts the user has written' do
    @user.update(posts_counter: 10)
    visit user_path(@user)
    expect(page).to have_content("Number of posts: 10")
  end

  it 'displays the user bio' do
    expect(page).to have_content(@user.bio)
  end

  it 'displays the user\'s first 3 posts' do
    recent_posts = @user.recent_posts.limit(3)
    recent_posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end

  it 'displays a button to view all user posts' do
    expect(page).to have_button('View All Posts')
  end

  it 'redirects to the post\'s show page when clicking a user\'s post' do
    post = Post.create(title: 'Sample Post', text: 'Sample post content', author_id: @user.id)
    visit user_path(@user)
    click_link post.title
    expect(current_path).to eq(user_post_path(user_id: @user.id, id: post.id))
  end

  it 'redirects to the user\'s post index page when clicking "View All Posts"' do
    posts = [
      Post.create(title: 'Post 1', text: 'Content 1', author_id: @user.id),
      Post.create(title: 'Post 2', text: 'Content 2', author_id: @user.id),
      Post.create(title: 'Post 3', text: 'Content 3', author_id: @user.id)
    ]

    visit user_path(@user)
    click_button 'View All Posts'
    expect(current_path).to eq(user_posts_path(user_id: @user.id))
    posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end
end
