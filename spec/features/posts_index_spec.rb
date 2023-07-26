require 'rails_helper'

RSpec.feature 'Post index page' do
  before do
    @user = User.create(name: 'User 1', photo: 'photo1.jpg')
    @post1 = @user.posts.create(title: 'Post 1', text: 'Content of post 1', likes_counter: 10)
    @post2 = @user.posts.create(title: 'Post 2', text: 'Content of post 2', likes_counter: 5)
    @post3 = @user.posts.create(title: 'Post 3', text: 'Content of post 3', likes_counter: 15)
    @comment1 = @post1.comments.create(text: 'Comment 1 for Post 1', user: @user)
    @comment2 = @post2.comments.create(text: 'Comment 1 for Post 2', user: @user)
    @comment3 = @post3.comments.create(text: 'Comment 1 for Post 3', user: @user)

    visit user_posts_path(user_id: @user.id)
  end

  scenario 'User details' do
    expect(page).to have_css("img.photo[src*='photo1.jpg']")
    expect(page).to have_content(@user.name)
    expect(page).to have_content('Number of posts: 3')
  end

  scenario 'Post titles and bodies' do
    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post2.title)
    expect(page).to have_content(@post3.title)
    expect(page).to have_content(@post1.text[0..10])
    expect(page).to have_content(@post2.text[0..10])
    expect(page).to have_content(@post3.text[0..10])
  end

  scenario 'Comments on posts' do
    expect(page).to have_content(@comment1.text)
    expect(page).to have_content(@comment2.text)
    expect(page).to have_content(@comment3.text)
    expect(page).to have_content('Comments: 1')
  end

  scenario 'Likes on posts' do
    expect(page).to have_content('Likes: 10')
    expect(page).to have_content('Likes: 5')
    expect(page).to have_content('Likes: 15')
  end

  scenario 'Redirect to post show page' do
    click_link @post1.title
    expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @post1.id))
  end
end
