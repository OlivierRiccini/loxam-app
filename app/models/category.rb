class Category < ApplicationRecord
  extend FriendlyId
  has_many :products
  friendly_id :name, use: :slugged
end
