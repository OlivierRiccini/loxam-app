class AddDocumentTypeToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :document_type, :string
  end
end
