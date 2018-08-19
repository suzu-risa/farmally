class CreateDataMigrations < ActiveRecord::Migration[5.2]
  def change
    create_table :data_migrations do |t|
      t.integer :version

      t.timestamps
    end
  end
end
