class Invoice < ApplicationRecord
  belongs_to :user
  mount_uploader :pdf, InvoiceUploader
end
