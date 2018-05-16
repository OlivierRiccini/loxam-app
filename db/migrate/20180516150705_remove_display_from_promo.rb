class RemoveDisplayFromPromo < ActiveRecord::Migration[5.1]
  def change
    remove_column :promos, :display, :string
  end
end
