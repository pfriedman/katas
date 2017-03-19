class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable

  validates :title, presence: true, length: { maximum: 140 }
  validates :body, presence: true
  validates :user, presence: true
end
