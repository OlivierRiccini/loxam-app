class AddBestSearchesChoiceToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :best_searches_choice, :boolean, default: false
  end
end
