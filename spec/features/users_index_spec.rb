require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  before do
    @users = [
      User.create(name: 'User 1', photo: 'photo1.jpg', posts_counter: 5),
      User.create(name: 'User 2', photo: 'photo2.jpg', posts_counter: 8),
      User.create(name: 'User 3', photo: 'photo3.jpg', posts_counter: 3)
    ]
    visit users_path
  end

  it 'displays the username of all other users' do
    @users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'displays the profile picture for each user' do
    @users.each do |user|
      expect(page).to have_css("img[src*='#{user.photo}'][alt='userPhoto']")
    end
  end

  it 'displays the number of posts each user has written' do
    @users.each do |user|
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
  end

  it 'redirects to the user show page when clicking on a user' do
    @users.each do |user|
      click_link user.name
      sleep 1
      expect(current_path).to eq(user_path(user))
      expect(page).to have_content(user.name)
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
      expect(page).to have_css("img[src*='#{user.photo}'][alt='userPhoto']")
      visit users_path
    end
  end
end
