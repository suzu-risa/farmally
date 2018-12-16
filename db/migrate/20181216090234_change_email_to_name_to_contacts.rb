class ChangeEmailToNameToContacts < ActiveRecord::Migration[5.2]
  def change
     rename_column :contacts, :email, :name
  end
end
