# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

CSV.foreach('db/master/category.csv') do |row|
  Category.create(:name => row[0], :code => row[1])
end

CSV.foreach('db/master/maker.csv') do |row|
  Maker.create(:name => row[0], :code => row[0])
end

if ENV['RAILS_ENV'] != 'production'
  CSV.foreach('db/master/sample_item.csv') do |row|
    FarmEquip.create(
        :maker_price => row[0],
        :used_price => row[1],
        :model => row[2],
        :size => row[5],
        :weight => row[6],
        :category_id => 1,
        :maker_id => 1,
    )
  end
end