class CreateStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :staffs do |t|
      t.string :name
      t.text :description
      t.string :phone_number

      t.timestamps
    end
  end
end
