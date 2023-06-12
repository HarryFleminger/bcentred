class BlogPost < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }
  has_one_attached :photo
end
