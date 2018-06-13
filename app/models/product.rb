class Product < ApplicationRecord
  has_many :transactions
  has_many :expendables
  belongs_to :category

  validates :name, presence: true
  validates :reference, uniqueness: true, presence: true
  validates :category, presence: true
  validates :price, presence: true
  # validates :photo, presence: true

  mount_uploader :photo, PhotoUploader
end
