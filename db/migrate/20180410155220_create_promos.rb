class CreatePromos < ActiveRecord::Migration[5.1]
  def change
    create_table :promos do |t|
      t.string :title
      t.string :media
      t.boolean :display, default: false
      t.boolean :display_description, default: false
      t.text :description

      t.timestamps
    end
  end
end
