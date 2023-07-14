require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'increments the LikesCounter of the associated post' do
    user = User.create(name: 'Tom Hardy', posts_counter: 0)
    post = Post.create(author_id: user.id, title: 'Second Post', text: 'More thoughts', comments_counter: 0,
                       likes_counter: 0)

    like = Like.create(author_id: user.id, post_id: post.id)
    expect { like.increment_likes_count }.to change { post.reload.likes_counter }.by(1)
  end

  it 'decrements the LikesCounter of the associated post' do
    user = User.create(name: 'Tom Hardy', posts_counter: 2)
    post = Post.create(author_id: user.id, title: 'Second Post', text: 'More thoughts', comments_counter: 6,
                       likes_counter: 4)

    like = Like.create(author_id: user.id, post_id: post.id)
    expect { like.decrement_likes_count }.to change { post.reload.likes_counter }.by(-1)
  end
end
