class AddAgencyToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :agency, :string
  end
end

