class AffiliateCategory < ApplicationRecord
  belongs_to :affiliate
  mount_uploader :image, AffiliateCategoryUploader
end
