class CatalogUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
