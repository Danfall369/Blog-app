class Like < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  belongs_to :post, foreign_key: 'post_id'

  after_create :increment_likes_count
  after_destroy :decrement_likes_count

  def increment_likes_count
    puts 'Increment Likes Count'
    post.increment!(:likes_counter)
  end

  def decrement_likes_count
    puts 'Decrement Likes Count'
    post.decrement!(:likes_counter)
  end
end
