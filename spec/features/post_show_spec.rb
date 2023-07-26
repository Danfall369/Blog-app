# spec/features/post_show_spec.rb
require 'rails_helper'

RSpec.describe 'Post Show', type: :feature do
  before do
    @user = User.create(name: 'Test User')
    @user2 = User.create(name: 'Test User 2')
    @user3 = User.create(name: 'Test User 3')
    @user4 = User.create(name: 'Test User 4')
    @post = Post.create(title: 'Test Post Title', text: 'Test post text', likes_counter: 5, user: @user)
    @comment1 = Comment.create(post_id: @post.id, author_id: @user2.id, text: 'Comment 1')
    @comment2 = Comment.create(post_id: @post.id, author_id: @user3.id, text: 'Comment 2')
    @comment3 = Comment.create(post_id: @post.id, author_id: @user4.id, text: 'Comment 3')
  end

  it "displays the post's title" do
    visit user_post_path(@user, @post)

    expect(page).to have_content('Test Post Title')
  end

  it "displays the author's name" do
    visit user_post_path(@user, @post)

    expect(page).to have_content('by: Test User')
  end

  it 'displays the number of comments' do
    visit user_post_path(@user, @post)

    expect(page).to have_content('Comments: 3')
  end

  it 'displays the number of likes' do
    visit user_post_path(@user, @post)

    expect(page).to have_content('Likes: 5')
  end

  it 'displays the post body' do
    visit user_post_path(@user, @post)

    expect(page).to have_content('Test post text')
  end

  it 'displays the username of each commenter' do
    visit user_post_path(@user, @post)

    expect(page).to have_css('.ul-comments-box li', count: 3)
    expect(page).to have_content('Test User 2')
    expect(page).to have_content('Test User 3')
    expect(page).to have_content('Test User 4')
  end

  it 'displays the comment each commenter left' do
    visit user_post_path(@user, @post)

    expect(page).to have_content('Comment 1')
    expect(page).to have_content('Comment 2')
    expect(page).to have_content('Comment 3')
  end
end
