class Document < ApplicationRecord
  belongs_to :user

  has_many :transactions, dependent: :destroy
  has_many :documents, through: :transactions

  validates :type, presence: true
end
