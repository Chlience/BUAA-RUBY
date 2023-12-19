class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :delivery_address
      t.string :delivery_name
      t.string :delivery_phone
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
