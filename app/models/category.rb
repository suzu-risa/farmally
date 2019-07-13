# == Schema Information
#
# Table name: categories
#
#  id                  :bigint(8)        not null, primary key
#  code                :string(255)
#  description_content :text(65535)
#  name                :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

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

  SellCategories = [
      {slug: "tractor", },
      {slug: "cultivator", },
      {slug: "combine", },
      {slug: "rice-planter", },
      {slug: "yumbo", },
      {slug: "harvester", },
      {slug: "threshing-machine", }
  ]

  def to_param
    code
  end
end
