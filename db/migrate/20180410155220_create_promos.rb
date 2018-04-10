class CreatePromos < ActiveRecord::Migration[5.1]
  def change
    create_table :promos do |t|
      t.string :catalogue
      t.string :display

      t.timestamps
    end
  end
end
