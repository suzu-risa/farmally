require "administrate/base_dashboard"

class SaleItemInquiryDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    sale_item: Field::BelongsTo,
    id: Field::Number,
    name: Field::String,
    phone_number: Field::String,
    address: Field::String,
    email: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :sale_item,
    :id,
    :name,
    :phone_number,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :sale_item,
    :id,
    :name,
    :phone_number,
    :address,
    :email,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :phone_number,
    :address,
    :email,
  ].freeze

  # Overwrite this method to customize how sale item inquiries are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(sale_item_inquiry)
  #   "SaleItemInquiry ##{sale_item_inquiry.id}"
  # end
  def display_resource(resource)
    "#{resource.class.model_name.human} ID: #{resource.id}"
  end
end
