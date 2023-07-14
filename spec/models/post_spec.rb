require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: 'post about testing', comments_counter: 5, likes_counter: 5) }

  before { subject.save }

  it 'Title must not be blank' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'Title must not exceed 250 characters' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'CommentsCounter must be an integer greater than or equal to zero' do
    subject.comments_counter = -5
    expect(subject).to_not be_valid
  end

  it 'LikesCounter must be an integer greater than or equal to zero' do
    subject.likes_counter = -5
    expect(subject).to_not be_valid
  end

  describe '#increment_post_count' do
    it 'increments the post_counter of the associated user' do
      user = User.create(name: 'Tom Hardy', posts_counter: 10)
      post = Post.create(author_id: user.id, title: 'First Testing Post', text: 'I expect to be success',
                         comments_counter: 5, likes_counter: 5)

      expect { post.increment_post_count }.to change { user.reload.posts_counter }.by(1)
    end
  end

  describe '#decrement_post_count' do
    it 'decrements the post_counter of the associated user' do
      user = User.create(name: 'Tom Hardy', posts_counter: 10)
      post = Post.create(author_id: user.id, title: 'First Testing Post', text: 'I expect to be success',
                         comments_counter: 5, likes_counter: 5)

      expect { post.decrement_post_count }.to change { user.reload.posts_counter }.by(-1)
    end
  end

  describe '#recent_comments' do
    it 'returns the five most recent comments' do
      # Create a user
      user = User.create(name: 'Tom Hardy', posts_counter: 0)

      # Create a post
      post = Post.create(author_id: user.id, title: 'First Testing Post', text: 'I expect to be success',
                         comments_counter: 5, likes_counter: 5)

      # Create test comments for the post
      Comment.create(post_id: post.id, author_id: user.id, text: 'Hi Tom!')
      comment2 = Comment.create(post_id: post.id, author_id: user.id, text: 'Hi Tom!')
      comment3 = Comment.create(post_id: post.id, author_id: user.id, text: 'Hi Tom!')
      comment4 = Comment.create(post_id: post.id, author_id: user.id, text: 'Hi Tom!')
      comment5 = Comment.create(post_id: post.id, author_id: user.id, text: 'Hi Tom!')
      comment6 = Comment.create(post_id: post.id, author_id: user.id, text: 'Hi Tom!')

      newer_comments = [comment6, comment5, comment4, comment3, comment2]

      # Ensure that only the five most recent comments are returned
      expect(post.recent_comments).to eq(newer_comments)
    end
  end
end
