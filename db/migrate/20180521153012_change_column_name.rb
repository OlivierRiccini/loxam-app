class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :characteristics, :features
  end
end
