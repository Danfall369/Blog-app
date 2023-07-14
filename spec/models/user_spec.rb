require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom Hardy', posts_counter: 10)}

  before { subject.save }

  it 'Name must not be blank' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'PostsCounter must be an integer greater than or equal to zero' do
    subject.posts_counter = -5
    expect(subject).to_not be_valid
  end

  describe 'recent_posts' do
    it 'should return 3 recent posts' do
      user = User.create(name: 'Tom Hardy', posts_counter: 0)
      Post.create(title: 'First Testing Post', comments_counter: 2, likes_counter: 1, author_id: user.id)
      post3 = Post.create(title: 'First Testing Post', comments_counter: 2, likes_counter: 1, author_id: user.id)
      post4 = Post.create(title: 'First Testing Post', comments_counter: 2, likes_counter: 1, author_id: user.id)
      post5 = Post.create(title: 'First Testing Post', comments_counter: 2, likes_counter: 1, author_id: user.id)
      expect(user.recent_posts).to eq([post5, post4, post3])
    end
  end
end
