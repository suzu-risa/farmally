class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :email, null: false
      t.string :phone_number, null: false
      t.integer :category, null: false, default: 0
      t.text :contents

      t.timestamps
    end
  end
end
