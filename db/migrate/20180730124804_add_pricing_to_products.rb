class AddPricingToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :pricing, :string, default: 'jour'
  end
end
