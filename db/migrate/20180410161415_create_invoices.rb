class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.integer :id_invoice_loxam
      t.string :pdf
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
