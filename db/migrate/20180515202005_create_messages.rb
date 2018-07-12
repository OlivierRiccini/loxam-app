class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :name
      t.string :email
      t.text :content
      t.boolean :checked, default: false

      t.timestamps
    end
  end
end
