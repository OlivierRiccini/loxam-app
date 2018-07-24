class CreateAffiliateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :affiliate_images do |t|
      t.string :url
      t.references :affiliate, foreign_key: true

      t.timestamps
    end
  end
end
