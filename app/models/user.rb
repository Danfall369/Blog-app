class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
  has_many :comments, foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  attribute :posts_counter, :integer, default: 0
  attribute :photo, :string, default: 'http://cdn.onlinewebfonts.com/svg/img_264570.png'

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_save :generate_api_token

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def generate_api_token
    self.api_token = SecureRandom.hex(16)
    puts "Generate API Token: #{api_token}"
  end
end
