class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :reference
      t.string :category
      t.integer :price
      t.string :characteristics
      t.text :description
      t.integer :deposit
      t.string :technical_sheet
      t.string :photo
      t.string :video
      t.string :loxam_link

      t.timestamps
    end
  end
end
