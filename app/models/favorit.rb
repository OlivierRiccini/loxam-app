class Favorit < ApplicationRecord
  belongs_to :user
  belongs_to :product
end
