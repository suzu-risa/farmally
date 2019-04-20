namespace :data_migration do
  desc 'Execute data migration'
  task exec: :environment do
    Rails.logger.info 'Start data migration task'

    # 新規にデータマイグレーションを行う場合はexec_migration_vXメソッドを足して、ここに追加する
    # NOTE 本当はファイルとかクラス分けたほうが良さそう
    DataMigration.exec_migration_v2
    DataMigration.exec_migration_v3
    DataMigration.exec_migration_v4
    DataMigration.exec_migration_v5
    DataMigration.exec_migration_v6
    DataMigration.exec_migration_v7

    Rails.logger.info 'Finish data migration task successfully'
  end
end
