class CreateCatalogs < ActiveRecord::Migration[5.1]
  def change
    create_table :catalogs do |t|
      t.string :catalog_type
      t.string :image
      t.string :link

      t.timestamps
    end
  end
end
