class Product < ApplicationRecord
  has_many :transactions
  belongs_to :category

  validates :name, presence: true
  validates :reference, uniqueness: true, presence: true
  validates :category, presence: true
  validates :price, presence: true
  # validates :photo, presence: true

  mount_uploader :photo, PhotoUploader
end
