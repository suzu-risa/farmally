namespace :data_migration do
  desc 'Execute data migration'
  task exec: :environment do
    Rails.logger.info 'Start data migration task'

    # 新規にデータマイグレーションを行う場合はここをincrementする
    exec_version = 2

    ActiveRecord::Base.transaction do
      model = DataMigration.find_by(version: exec_version)
      if model.present?
        Rails.logger.info 'Exit data migration task because this migration is already done'
        next
      end

      # 実際のデータマイグレーション内容を記述する

      ## メーカーのcodeを英字に変更
      CSV.foreach('db/data_migrate/makers.csv', headers: true) do |row|
        maker = Maker.find_by(id: row['id'])
        maker.update(code: row['code']) if maker.present?
      end

      ## 既存のカテゴリー・商品を削除
      Item.destroy_all
      Category.destroy_all

      ## 新しいカテゴリー・サブカテゴリーの登録
      CSV.foreach('db/data_migrate/categories.csv', headers: true) do |row|
        Category.create(name: row['category'], code: row['code'])
      end
      category_ids = Hash[*Category.all.map { |c| [c.code, c.id] }.flatten]
      CSV.foreach('db/data_migrate/sub_categories.csv', headers: true) do |row|
        SubCategory.create(
          name: row['sub_category'],
          code: row['code'],
          category_id: category_ids[row['category_code']]
        )
      end

      # ここまで

      DataMigration.create!(version: exec_version)
      Rails.logger.info 'Finish data migration task successfully'
    end
  end
end
