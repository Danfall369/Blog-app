require 'rails_helper'

Rspec.describe User, type: :model do
  subject { User.new(name: 'Tom Hardy', posts_counter: 10)}

  before { subject.save }

  it 'Name must not be blank' do
    subject.name = nil
    expect(subject).to_not_be_valid
  end

  it 'PostsCounter must be an integer greater than or equal to zero' do
    subject.posts_counter = -5
    expect(subject).to_not_be_valid
  end
end