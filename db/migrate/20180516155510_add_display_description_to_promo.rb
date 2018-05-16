class AddDisplayDescriptionToPromo < ActiveRecord::Migration[5.1]
  def change
    add_column :promos, :display_description, :boolean, default: false
  end
end
