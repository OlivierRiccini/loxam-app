class RemoveTypeFromDocument < ActiveRecord::Migration[5.1]
  def change
    remove_column :documents, :type, :string
  end
end
