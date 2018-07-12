class AddPdfToDocument < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :pdf, :string
  end
end
