require "administrate/base_dashboard"

class SaleItemDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    item: Field::BelongsTo,
    sale_item_template: Field::BelongsTo.with_options(
      class_name: "SaleItemTemplate"
    ),
    id: Field::Number,
    price: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :item,
    :sale_item_template,
    :id,
    :price,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :item,
    :sale_item_template,
    :id,
    :price,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :item,
    :price,
    :sale_item_template,
  ].freeze

  # Overwrite this method to customize how sale items are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(sale_item)
  #   "SaleItem ##{sale_item.id}"
  # end

  def display_resource(resource)
    "#{resource.class.model_name.human} ID: #{resource.id}"
  end
end
