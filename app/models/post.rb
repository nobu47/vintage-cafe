class Post < ApplicationRecord
  belongs_to :user
  
  validates :image, presence: true
  
  mount_uploader :image, ImageUploader
  
  has_many :favorites
  has_many :users, through: :favorites
end
