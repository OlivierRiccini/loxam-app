class Product < ApplicationRecord
  extend FriendlyId
  # has_many :transactions
  has_many :expendables, dependent: :destroy
  accepts_nested_attributes_for :expendables, reject_if: :all_blank, allow_destroy: true
  has_many :favorites
  has_many :users, :through => :favorites
  belongs_to :category


  validates :name, presence: true
  friendly_id :name, use: :slugged
  validates :reference, uniqueness: true, presence: true
  validates :category, presence: true
  validates :price, presence: true
  # validates :photo, presence: true

  mount_uploader :photo, PhotoUploader
  mount_uploader :technical_sheet, TechnicalSheetUploader
  mount_uploader :features, FeaturesUploader
end
