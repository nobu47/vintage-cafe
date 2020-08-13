class Post < ApplicationRecord
  belongs_to :user
  
  validates :image, presence: true
  
  mount_uploader :image, ImageUploader
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  has_many :comments, dependent: :destroy
  
end
