class AddBestnewProductChoiceToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :new_product_choice, :boolean, default: false
  end
end
