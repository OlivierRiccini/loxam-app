class AddTitleToPromo < ActiveRecord::Migration[5.1]
  def change
    add_column :promos, :title, :string
  end
end
