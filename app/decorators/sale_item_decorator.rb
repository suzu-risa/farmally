module SaleItemDecorator
  def attribute_list_text
    [year_text, prefecture_name, status_i18n, horse_power_text, used_hours_text]
      .select(&:present?).join(" / ")
  end

  private

    def year_text
      year ? "#{year}年式" : nil
    end

    def horse_power_text
      horse_power ? "#{horse_power}馬力" : nil
    end

    def used_hours_text
      used_hours ? "アワーメーター#{used_hours}h" : nil
    end
end
