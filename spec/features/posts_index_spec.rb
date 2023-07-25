require 'rails_helper'

RSpec.feature 'Post index page' do
    before do
        @user = User.create(name: 'User 1', photo: 'photo1.jpg')
    
        @post1 = @user.posts.create(title: 'Post 1', text: 'Content of post 1', likes_counter: 10)
        @post2 = @user.posts.create(title: 'Post 2', text: 'Content of post 2', likes_counter: 5)
        @post3 = @user.posts.create(title: 'Post 3', text: 'Content of post 3', likes_counter: 15)
    
        # Create comments for post1, post2, and post3
        @comment1 = @post1.comments.create(text: 'Comment 1 for Post 1', user: @user)
        @comment2 = @post2.comments.create(text: 'Comment 1 for Post 2', user: @user)
        @comment3 = @post3.comments.create(text: 'Comment 1 for Post 3', user: @user)
    
        visit user_posts_path(user_id: @user.id)
    end

  scenario 'I can see the user\'s profile picture' do
    expect(page).to have_css("img.photo[src*='photo1.jpg']")
  end

  scenario 'I can see the user\'s username' do
    expect(page).to have_content(@user.name)
  end

  scenario 'I can see the number of posts the user has written' do
    expect(page).to have_content("Number of posts: 3")
  end

  scenario 'I can see a post\'s title' do
    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post2.title)
    expect(page).to have_content(@post3.title)
  end

  scenario 'I can see some of the post\'s body' do
    expect(page).to have_content(@post1.text[0..10])
    expect(page).to have_content(@post2.text[0..10])
    expect(page).to have_content(@post3.text[0..10])
  end

  scenario 'I can see the first comments on a post' do
    expect(page).to have_content(@comment1.text)
    expect(page).to have_content(@comment2.text)
    expect(page).to have_content(@comment3.text)
  end

  scenario 'I can see how many comments a post has' do
    expect(page).to have_content("Comments: 1")
  end

  scenario 'I can see how many likes a post has' do
    expect(page).to have_content("Likes: 10") 
    expect(page).to have_content("Likes: 5")  
    expect(page).to have_content("Likes: 15") 
  end

  scenario 'When I click on a post, it redirects me to that post\'s show page' do
    click_link @post1.title
    expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @post1.id))
  end
end
