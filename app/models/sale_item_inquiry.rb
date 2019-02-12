# == Schema Information
#
# Table name: sale_item_inquiries
#
#  id           :bigint(8)        not null, primary key
#  address      :string(255)
#  contents     :text(65535)
#  email        :string(255)
#  kind         :integer
#  name         :string(255)      not null
#  phone_number :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  sale_item_id :bigint(8)
#
# Indexes
#
#  index_sale_item_inquiries_on_sale_item_id  (sale_item_id)
#
# Foreign Keys
#
#  fk_rails_...  (sale_item_id => sale_items.id)
#

class SaleItemInquiry < ApplicationRecord
  belongs_to :sale_item

  enum kind: { condition: 1, estimate: 2, check_reserve: 3, change_price_alert: 4, other: 0 }

  delegate :model, :item, :category_name, :price, to: :sale_item

  def prettify
    <<~TXT
      *出品商品に関するお問い合わせ*
      #{admin_url}
      #{client_url}

      機械の種類: #{category_name}
      機械の型式: #{model}
      価格: #{price.present? ? price : '未入力'}
      お名前: #{name}
      電話番号: #{phone_number}
      メールアドレス：#{email}
      お問い合わせ内容: #{kind_i18n}
      備考欄: #{contents? ? contents : '記入なし'}
    TXT
  end

  def admin_url
    Rails.application.routes.url_helpers.admin_sale_item_inquiry_url(sale_item_id, id)
  end

  def client_url
    Rails.application.routes.url_helpers.item_sale_item_url(item, sale_item)
  end
end
