# == Schema Information
#
# Table name: categories
#
#  id                  :bigint(8)        not null, primary key
#  code                :string(255)
#  description_content :text(65535)
#  displayable         :boolean
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

  scope :displayed, -> {
    where(displayable: true)
  }

  Displayed = 1

  Slugs = {
      tractor: "tractor",
  }

  SellCategories = [
      {slug: Slugs[:tractor], title: "トラクター", id: "5cc531339019733065188446" },
      {slug: "combine",title: "コンバイン", id: "5d297b0537992c75fac179bf" },
      {slug: "rice-planter", title: "田植え機", id: "5d297b2b5ed50670d329e45b" }
  ]

  # SellCategories = [
  #   {slug: Slugs[:tractor], title: "トラクター", id: "5cc531339019733065188446" },
  #   # {slug: "cultivator",title: "耕運機", id: "5d297ad85ed50670d329e454"  },
  #   {slug: "combine",title: "コンバイン", id: "5d297b0537992c75fac179bf" },
  #   {slug: "rice-planter", title: "田植え機", id: "5d297b2b5ed50670d329e45b" },
  #   # {slug: "yumbo",title: "ユンボ", id: "5d297b4c9ee50272997af2d6" },
  #   # {slug: "harvester",title: "収穫期", id: "5d297b685ed50670d329e45c" },
  #   # {slug: "threshing-machine",title: "脱穀機", id: "5d297b935ed50670d329e464" },
  # ]

  def to_param
    code
  end
end
