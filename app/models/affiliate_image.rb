class AffiliateImage < ApplicationRecord
  belongs_to :affiliate
  mount_uploader :url, AffiliateImageUploader
end
