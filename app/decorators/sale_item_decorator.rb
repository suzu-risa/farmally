module SaleItemDecorator
  def attribute_list_text
    [year_text, prefecture_name, status_i18n, horse_power_with_unit, used_hours_text]
      .select(&:present?).join(" / ")
  end

  def year_text
    year ? "#{year}#{self.class.human_attribute_name(:year)}" : nil
  end

  def horse_power_with_unit
    horse_power ? "#{horse_power}#{self.class.human_attribute_name(:horse_power)}" : nil
  end

  def used_hours_with_unit
    used_hours ? "#{used_hours}h" : nil
  end

  def show_path
    item_sale_item_path(id, item_id: item_id)
  end

  private

    def used_hours_text
      used_hours ? "#{self.class.human_attribute_name(:used_hours)}#{used_hours_with_unit}" : nil
    end
end
