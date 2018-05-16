class AddNbOfSearchesToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :nb_of_searches, :integer, default: 0
  end
end
