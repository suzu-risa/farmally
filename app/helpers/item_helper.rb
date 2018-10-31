module ItemHelper
  # 小売希望価格を表示する(範囲か単数で表示)
  # DBには千円単位で格納されているので, 1,000倍にして表示する
  def maker_price_range(item)
    if item.maker_price.blank? && item.sub_maker_price.blank?
      return '-'
    elsif item.maker_price.present? && item.sub_maker_price.blank?
      return print_price(item.maker_price * 1000)
    elsif item.maker_price.blank? && item.sub_maker_price.present?
      return print_price(item.sub_maker_price * 1000)
    end

    if item.maker_price > item.sub_maker_price
      "#{print_price(item.sub_maker_price * 1000)}〜#{print_price(item.maker_price * 1000)}"
    else
      "#{print_price(item.maker_price * 1000)}〜#{print_price(item.sub_maker_price * 1000)}"
    end
  end
end
