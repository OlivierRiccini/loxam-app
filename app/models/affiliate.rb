class Affiliate < ApplicationRecord
  has_many :affiliate_categories
  has_many :affiliate_images
  mount_uploader :logo, AffiliateUploader
end
