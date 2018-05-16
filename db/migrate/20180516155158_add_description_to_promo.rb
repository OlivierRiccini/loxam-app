class AddDescriptionToPromo < ActiveRecord::Migration[5.1]
  def change
    add_column :promos, :description, :text
  end
end
