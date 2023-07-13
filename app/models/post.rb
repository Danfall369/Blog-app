class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  after_create :increment_post_count
  after_destroy :decrement_post_count

  def increment_post_count
    puts 'Increment Post Count'
    user.increment!(:posts_counter)
  end

  def decrement_post_count
    puts 'Decrement Post Count'
    user.decrement!(:posts_counter)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
end
end
