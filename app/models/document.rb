class Document < ApplicationRecord
  belongs_to :user
  has_many :transactions

  validates :type, presence: true
end
