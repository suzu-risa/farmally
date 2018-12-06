class Category < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :sub_categories, dependent: :destroy
  has_one :sale_item_template

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true

  scope :not_has_sale_item_templates, -> {
    includes(:sale_item_template)
      .where(SaleItemTemplate.table_name => { id: nil })
  }

  def to_param
    code
  end
end
