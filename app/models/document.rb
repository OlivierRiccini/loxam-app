class Document < ApplicationRecord
  belongs_to :user

  has_many :transactions, dependent: :destroy
  has_many :products, through: :transactions

  validates :document_type, presence: true
end
