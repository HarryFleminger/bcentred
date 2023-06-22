class Employee < ApplicationRecord
  validates :first_name, :last_name, :position, :bio, presence: true
  has_one_attached :photo
end
