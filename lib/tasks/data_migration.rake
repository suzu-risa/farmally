namespace :data_migration do
  desc 'Execute data migration'
  task exec: :environment do
    Rails.logger.info 'Start data migration task'

    # 新規にデータマイグレーションを行う場合はここをincrementする
    exec_version = 1

    ActiveRecord::Base.transaction do
      model = DataMigration.find_by(version: exec_version)
      if model.present?
        Rails.logger.info 'Exit data migration task because this migration is already done'
        next
      end

      # 実際のデータマイグレーション内容を記述する
      CSV.foreach('db/master/category.csv') do |row|
        Category.create!(name: row[0], code: row[1])
      end

      CSV.foreach('db/master/maker.csv') do |row|
        Maker.create!(name: row[0], code: row[0])
      end
      # ここまで

      DataMigration.create!(version: exec_version)
      Rails.logger.info 'Finish data migration task successfully'
    end
  end
end
