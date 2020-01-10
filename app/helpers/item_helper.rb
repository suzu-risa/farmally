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

  def prefecture_name(prefecture_code)
    JpPrefecture::Prefecture.find(prefecture_code).name
  end

  def show_remark_in_template(sale_item)
    remark = nil;
    sale_item.detail_with_template.tables.each do |table|
      table.properties.each do |property|
        remark = simple_format(property.value) if property.name == "備考"
      end
    end
    remark
  end
end
