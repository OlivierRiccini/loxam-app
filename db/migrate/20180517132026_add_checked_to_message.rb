class AddCheckedToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :checked, :boolean, default: false
  end
end
