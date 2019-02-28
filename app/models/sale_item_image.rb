# == Schema Information
#
# Table name: sale_item_images
#
#  id           :bigint(8)        not null, primary key
#  position     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  sale_item_id :bigint(8)
#
# Indexes
#
#  index_sale_item_images_on_sale_item_id  (sale_item_id)
#
# Foreign Keys
#
#  fk_rails_...  (sale_item_id => sale_items.id)
#

class SaleItemImage < ApplicationRecord
  belongs_to :sale_item

  has_one_attached :image
end
