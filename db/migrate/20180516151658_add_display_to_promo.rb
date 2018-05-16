class AddDisplayToPromo < ActiveRecord::Migration[5.1]
  def change
    add_column :promos, :display, :boolean, default: false
  end
end
