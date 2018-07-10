class DocumentUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
