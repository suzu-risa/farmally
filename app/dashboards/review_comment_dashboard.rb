require "administrate/base_dashboard"

class ReviewCommentDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    review: Field::BelongsTo,
    id: Field::Number,
    name: Field::String,
    content: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    approved: Field::Boolean
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :review,
    :name,
    :approved
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :review,
    :name,
    :content,
    :approved,
    :created_at,
    :updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :approved
  ].freeze

  # Overwrite this method to customize how review comments are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(review_comment)
  #   "ReviewComment ##{review_comment.id}"
  # end
end
