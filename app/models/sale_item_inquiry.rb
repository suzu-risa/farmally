class SaleItemInquiry < ApplicationRecord
  belongs_to :sale_item

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
      お問い合わせ内容: #{contents? ? contents : '記入なし'}
    TXT
  end

  def admin_url
    Rails.application.routes.url_helpers.admin_sale_item_inquiry_url(sale_item_id, id)
  end

  def client_url
    Rails.application.routes.url_helpers.item_sale_item_url(item, sale_item)
  end
end
