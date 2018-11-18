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
end
