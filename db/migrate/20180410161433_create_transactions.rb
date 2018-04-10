class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :product, foreign_key: true
      t.references :document, foreign_key: true

      t.timestamps
    end
  end
end
