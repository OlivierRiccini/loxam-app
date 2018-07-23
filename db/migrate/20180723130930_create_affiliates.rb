class CreateAffiliates < ActiveRecord::Migration[5.1]
  def change
    create_table :affiliates do |t|
      t.string :name
      t.text :tagline
      t.string :logo

      t.timestamps
    end
  end
end
