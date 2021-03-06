require 'administrate/base_dashboard'

class ItemDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    maker: Field::BelongsTo,
    category: Field::BelongsTo,
    sub_category: Field::BelongsTo,
    id: Field::Number,
    maker_price: Field::Number,
    sub_maker_price: Field::Number,
    used_price: Field::Number,
    model: Field::String,
    horse_power: Field::String,
    original_horse_power: Field::String,
    size: Field::String,
    weight: Field::String,
    machine_type: Field::String,
    work_efficiency: Field::String,
    other: Field::Text,
    created_at: Field::DateTime.with_options(export: false),
    updated_at: Field::DateTime.with_options(export: false)
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :category,
    :sub_category,
    :maker,
    :model,
    :maker_price,
    :used_price
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :maker,
    :category,
    :sub_category,
    :id,
    :maker_price,
    :sub_maker_price,
    :used_price,
    :model,
    :horse_power,
    :original_horse_power,
    :size,
    :weight,
    :machine_type,
    :work_efficiency,
    :other,
    :created_at,
    :updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :maker,
    :category,
    :sub_category,
    :maker_price,
    :sub_maker_price,
    :used_price,
    :model,
    :horse_power,
    :original_horse_power,
    :size,
    :weight,
    :machine_type,
    :work_efficiency,
    :other
  ].freeze

  # Overwrite this method to customize how items are displayed
  # across all pages of the admin dashboard.
  def display_resource(item)
    item.model
  end
end
