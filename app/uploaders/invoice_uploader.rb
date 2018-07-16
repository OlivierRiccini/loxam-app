class InvoiceUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
