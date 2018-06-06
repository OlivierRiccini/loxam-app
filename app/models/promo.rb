class Promo < ApplicationRecord
  mount_uploader :media, PhotoUploader

  validates :title, presence: true
  validates :description, presence: true
end
