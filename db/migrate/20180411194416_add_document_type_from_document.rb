class AddDocumentTypeFromDocument < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :document_type, :string
  end
end
