class Invoice < ApplicationRecord
  belongs_to :user

  has_many :transactions, dependent: :destroy
  has_many :products, through: :transactions

  mount_uploader :pdf, InvoiceUploader
end
