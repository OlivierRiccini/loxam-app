class BillingUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
