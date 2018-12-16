# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

# カテゴリー
CSV.foreach('db/master/category.csv') do |row|
  Category.create(name: row[0], code: row[1])
end

# サブカテゴリー
category_ids = Hash[*Category.all.map { |c| [c.code, c.id] }.flatten]
CSV.foreach('db/data_migrate/additional_sub_categories.csv', headers: true) do |row|
  SubCategory.create(
    name: row['sub_category'],
    code: row['code'],
    category_id: category_ids[row['category_code']]
  )
end

# メーカー
CSV.foreach('db/master/maker.csv') do |row|
  Maker.create(name: row[1], code: row[2])
end

if ENV['RAILS_ENV'] != 'production'
  sub_category = SubCategory.first # TODO: CSVにサブカテゴリも含める
  CSV.foreach('db/master/sample_item.csv') do |row|
    Item.create(
      maker_price: row[0],
      used_price: row[1],
      model: row[2],
      size: row[5],
      weight: row[6],
      category_id: sub_category.category_id,
      sub_category_id: sub_category.id,
      maker_id: 1,
    )
  end

  SaleItemTemplate.create(
    category_id: sub_category.category_id,
    detail_file: File.open("db/master/sample_sale_item_template.csv")
  )

  ([nil] * 10 + [Time.zone.local(2018,12,1)] * 10).each do |sold_at|
    SaleItem.create!(
      item: Item.first,
      sale_item_template: SaleItemTemplate.first,
      detail_json: JSON.parse(File.read("db/master/sample_sale_item_detail.json")),
      sold_at: sold_at
    )
  end
end
