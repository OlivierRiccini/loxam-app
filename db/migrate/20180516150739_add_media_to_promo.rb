class AddMediaToPromo < ActiveRecord::Migration[5.1]
  def change
    add_column :promos, :media, :string
  end
end
