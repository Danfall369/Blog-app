class Comment < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  belongs_to :post, foreign_key: 'post_id'

  after_create :increment_comment_count
  after_destroy :decrement_comment_count
  after_save :increment_comment_count, :decrement_comment_count

  def increment_comment_count
    puts 'Increment Comment Count'
    post.increment!(:comments_counter)
  end

  def decrement_comment_count
    puts 'Decrement Comment Count'
    post.decrement!(:comments_counter)
  end
end
