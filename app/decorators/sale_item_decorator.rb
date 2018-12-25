module SaleItemDecorator
  def year_text
    year? ? "#{year}#{self.class.human_attribute_name(:year)}" : "-"
  end

  def horse_power_with_unit
    horse_power? ? "#{horse_power}" : "-"
  end

  def used_hours_with_unit
    used_hours? ? "#{used_hours}h" : "-"
  end

  def show_path
    item_sale_item_path(id, item_id: item_id)
  end

  def display_status
    status? ? status_i18n : "-"
  end
end
