class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :reference
      t.references :category, foreign_key: true
      t.integer :price
      t.string :features
      t.text :description
      t.integer :deposit
      t.string :technical_sheet
      t.string :photo
      t.string :video
      t.string :loxam_link
      t.boolean :new_product_choice, default: false
      t.boolean :best_searches_choice, default: false
      t.integer :nb_of_searches, default: 0
      t.integer :present_in_favorites, default: 0

      t.timestamps
    end
  end
end
