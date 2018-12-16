# == Schema Information
#
# Table name: sale_item_templates
#
#  id          :bigint(8)        not null, primary key
#  detail_json :json
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint(8)
#
# Indexes
#
#  index_sale_item_templates_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#

require 'tempfile'

class SaleItemTemplate < ApplicationRecord
  belongs_to :category

  validate :detail_property_keys_must_be_uniq
  validates :category_id, uniqueness: true
  validates :detail_json, presence: true
  validates :detail_tables, presence: true

  delegate :name, to: :category, prefix: :category

  def detail_file=(file)
    table_names = {}

    detail_hash = {
      "tables" => {
      }
    }

    CSV.foreach(file.path, headers: true) do |row|
      table_num = row["table"]
      table_name = row["table_name"]
      property_key = row["property_key"] # Hashieの都合で`key`が使えないため
      property_name = row["property_name"]
      next if property_key.nil? || property_name.nil?
      property = { property_key: row["property_key"].strip, property_name: row["property_name"].strip }

      unless detail_hash["tables"][table_num]
        detail_hash["tables"][table_num] = {}
      end

      if table_name.present? && detail_hash["tables"][table_num]
        detail_hash["tables"][table_num]["name"] = table_name
      end

      if detail_hash["tables"][table_num]["properties"]
        detail_hash["tables"][table_num]["properties"].push(property)
      else
        detail_hash["tables"][table_num]["properties"] = [property]
      end
    end

    detail_hash["tables"] =
      detail_hash["tables"].sort_by{|k, v| k }.map(&:last)

    self.detail_json = detail_hash.to_json
  end

  def detail_file
    data = [["table", "table_name", "property_key", "property_name"]]
    detail.tables.each.with_index(1) do |table, i|
      table.properties.each do |property|
        data.push(
          [i, table.name, property.property_key, property.property_name]
        )
      end
    end

    file = Tempfile.new

    CSV.open(file.path, 'w') do |csv|
      data.each do |row|
        csv << row
      end
    end

    file
  end

  def detail
    Hashie::Mash.new(JSON.parse(detail_json))
  end

  def detail_tables
    detail.tables
  end

  private

  def detail_property_keys
    detail.tables.map(&:properties).flatten.map(&:property_key)
  end

  def detail_property_keys_must_be_uniq
    if detail_property_keys.size != detail_property_keys.uniq.size
      errors.add(:detail_json, "property_keyはユニークである必要があります")
    end
  end
end
