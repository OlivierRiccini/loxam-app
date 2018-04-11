class RemoveCompagnyFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :compagny, :string
  end
end
