require "administrate/base_dashboard"

class ItemMarketPriceDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    category_name: Field::String,
    sub_category_name: Field::String,
    area: Field::String,
    maker_name: Field::String,
    model: Field::String,
    sold_count: Field::Number,
    detail_json: Field::Text,
    from_year: Field::Number,
    to_year: Field::Number,
    max_price: Field::Number,
    average_price: Field::Number,
    min_price: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    number_of_thread: Field::Number,
    tank: Field::Boolean,
    planting_method: Field::String,
    cabin: Field::Boolean,
    fertilizer: Field::Boolean,
    horse_power: Field::Number,
    drive_system: Field::String,
    safety_frame: Field::String,
    rotary: Field::Boolean,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :category_name,
    :sub_category_name,
    :area,
    :maker_name,
    :model,
    :sold_count,
    :from_year,
    :to_year,
    :max_price,
    :average_price,
    :min_price,
    :created_at,
    :updated_at,
    :number_of_thread,
    :tank,
    :planting_method,
    :cabin,
    :fertilizer,
    :horse_power,
    :drive_system,
    :safety_frame,
    :rotary,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :category_name,
    :sub_category_name,
    :area,
    :maker_name,
    :model,
    :sold_count,
    :detail_json,
    :from_year,
    :to_year,
    :max_price,
    :average_price,
    :min_price,
    :created_at,
    :updated_at,
    :number_of_thread,
    :tank,
    :planting_method,
    :cabin,
    :fertilizer,
    :horse_power,
    :drive_system,
    :safety_frame,
    :rotary,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :category_name,
    :sub_category_name,
    :area,
    :maker_name,
    :model,
    :sold_count,
    :detail_json,
    :from_year,
    :to_year,
    :max_price,
    :average_price,
    :min_price,
    :number_of_thread,
    :tank,
    :planting_method,
    :cabin,
    :fertilizer,
    :horse_power,
    :drive_system,
    :safety_frame,
    :rotary,
  ].freeze

  # Overwrite this method to customize how item market prices are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(item_market_price)
  #   "ItemMarketPrice ##{item_market_price.id}"
  # end
end
