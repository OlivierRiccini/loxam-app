class CreateAffiliateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :affiliate_categories do |t|
      t.string :name
      t.text :spec
      t.text :description
      t.string :image
      t.references :affiliate, foreign_key: true

      t.timestamps
    end
  end
end
