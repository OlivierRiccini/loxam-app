class Catalog < ApplicationRecord
  mount_uploader :image, CatalogUploader
end
