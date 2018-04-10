class Product < ApplicationRecord
  has_many :transactions

  validates :name, presence: true
  validates :reference, uniqueness: true, presence: true
  validates :category, presence: true
  validates :price, presence: true

  mount_uploader :photo, PhotoUploader
end
