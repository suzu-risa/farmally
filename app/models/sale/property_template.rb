class Sale::PropertyTemplate < ApplicationRecord
  belongs_to :category
  has_many :properties,
           -> { order(position: :asc) },
           foreign_key: :sale_property_template_id,
           inverse_of: :template

  accepts_nested_attributes_for :properties,
                                allow_destroy: true,
                                reject_if: ->(prop){
                                  prop[:name].blank?
                                }

  validate :detail_property_keys_must_be_uniq

  def detail_file=(file)
    table_names = {}

    detail_hash = {
      "tables" => {
      }
    }

    CSV.foreach(file.path, headers: true) do |row|
      table_num = row["table"]
      table_name = row["table_name"]
      property_key = row["property_key"]
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
  end

  def detail
    Hashie::Mash.new(JSON.parse(detail_json))
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
