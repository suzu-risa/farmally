# == Schema Information
#
# Table name: data_migrations
#
#  id         :bigint(8)        not null, primary key
#  version    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DataMigration < ApplicationRecord
  class << self
    def exec_migration_v2
      migrate(2) do
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
      end
    end

    def exec_migration_v3
      migrate(3) do
        category_ids = Hash[*Category.all.map { |c| [c.code, c.id] }.flatten]
        CSV.foreach('db/data_migrate/additional_sub_categories.csv', headers: true) do |row|
          SubCategory.create!(
            name: row['sub_category'],
            code: row['code'],
            category_id: category_ids[row['category_code']]
          )
        end
      end
    end

    def exec_migration_v4
      migrate(4) do
        SaleItem.all.each(&:migrate_images_to_sale_item_images)
      end
    end

    def exec_migration_v5
      migrate(5) do
        Item.all.where(original_horse_power: [nil, ""]).each do |item|
          item.update!(original_horse_power: item.horse_power)
        end
      end
    end

    def exec_migration_v6
      migrate(6) do
        Item.all.where.not(original_horse_power: [nil, ""]).each do |item|
          item.creansing_horse_power!
        end
      end
    end

    private
      def migrate(exec_version, &block)
        if DataMigration.exists?(version: exec_version)
          Rails.logger.info(
            "Skip data migration task because this migration version #{exec_version} is already done"
          )

          return
        end

        ActiveRecord::Base.transaction do
          block.call
        end

        DataMigration.create!(version: exec_version)
      end
  end
end
