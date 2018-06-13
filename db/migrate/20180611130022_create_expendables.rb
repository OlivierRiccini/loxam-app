class CreateExpendables < ActiveRecord::Migration[5.1]
  def change
    create_table :expendables do |t|
      t.string :name
      t.string :reference
      t.float :price
      t.text :description
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
