require "administrate/base_dashboard"

class ReviewDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    # picture_attachment: Field::HasOne,
    # picture_blob: Field::HasOne,
    item: Field::BelongsTo,
    id: Field::Number,
    content: Field::Text,
    star: Field::String.with_options(searchable: false),
    like_count: Field::Number,
    approved: Field::Boolean
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    # :picture_attachment,
    # :picture_blob,
    :id,
    :item,
    :star,
    :like_count,
    :approved
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    # :picture_attachment,
    # :picture_blob,
    :id,
    :item,
    :content,
    :star,
    :like_count,
    :approved
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    # :picture_attachment,
    # :picture_blob,
    # :item,
    # :content,
    # :star,
    # :status,
    # :purchase_price,
    :approved
  ].freeze

  # Overwrite this method to customize how reviews are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(review)
  #   "Review ##{review.id}"
  # end
end
