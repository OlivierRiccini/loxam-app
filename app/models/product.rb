class Product < ApplicationRecord
  has_many :transactions
  has_many :expendables
  has_many :favorites
  has_many :users, :through => :favorites
  belongs_to :category

  validates :name, presence: true
  validates :reference, uniqueness: true, presence: true
  validates :category, presence: true
  validates :price, presence: true
  # validates :photo, presence: true

  mount_uploader :photo, PhotoUploader
  mount_uploader :technical_sheet, TechnicalSheetUploader
  mount_uploader :features, FeaturesUploader
end
