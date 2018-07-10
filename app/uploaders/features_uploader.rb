class FeaturesUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
