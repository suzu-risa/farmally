# == Schema Information
#
# Table name: item_market_prices
#
#  id                :bigint(8)        not null, primary key
#  area              :string(255)      not null
#  average_price     :integer          not null
#  category_name     :string(255)      not null
#  detail_json       :text(65535)
#  from_year         :integer          not null
#  maker_name        :string(255)      not null
#  max_price         :integer          not null
#  min_price         :integer          not null
#  model             :string(255)      not null
#  sold_count        :integer          not null
#  sub_category_name :string(255)      not null
#  to_year           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class ItemMarketPrice < ApplicationRecord
  class << self
    def import_from_all_file
      Dir.glob("./db/used_market_price_book_data/*").each do |csv_file_path|
        import_from_csv(csv_file_path)
      end
    end

    def import_from_csv(csv_file_path)
      importer = ItemMarketPriceCsvImporter.new(csv_file_path)
      importer.import!
    end
  end
end
