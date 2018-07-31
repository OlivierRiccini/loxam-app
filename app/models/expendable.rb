class Expendable < ApplicationRecord
  belongs_to :product, optional: true
end
