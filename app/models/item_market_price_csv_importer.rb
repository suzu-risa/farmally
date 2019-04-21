class ItemMarketPriceCsvImporter
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @maker_name_index = 1
    @model_name_index = 2
    @sold_count_index = 3

    @category_name_row_index = 0
    @sub_category_name_row_index = 1
    @area_row_index = 2

    @header_up_row_index = 4
    @header_down_row_index = 5
  end

  def import!
    reset_row_index
    CSV.foreach(csv_file_path, headers: false) do |row|
      case row_index
      when @category_name_row_index
        @category_name = row[0].gsub(/^\d　*/, '').strip
      when @sub_category_name_row_index
        @sub_category_name = row[1].gsub(/^\(\d+ *\)/, '')
      when @area_row_index
        @area = row[1][1..-1]
      when @header_up_row_index
        @from_year_index = row.index("年式及び初販年")
        @to_year_index = from_year_index + 3
        @max_price_index = to_year_index + 1
        @average_price_index = max_price_index + 1
        @min_price_index = max_price_index + 2

        @detail_index_from = row.index("台数") + 1
        @detail_index_to = from_year_index - 1

        @detail_up = row[detail_index_from..detail_index_to]
      when @header_down_row_index
        @detail_down = row[detail_index_from..detail_index_to]
      when 3 # 空行
      else
        detail = {}

        detail_up.each_with_index do |key, i|
          if key.present?
            if detail_down[i].present?
              detail[key] = {
                detail_down[i] => row[detail_index_from + i]
              }
            else
              detail[key] = row[detail_index_from + i]
            end
          else
            detail[detail.keys.last] =
              detail[detail.keys.last].merge(
                detail_down[i] => row[detail_index_from + i]
              )
          end
        end

        number_of_thread =
          detail["条数"] ? detail["条数"].to_i : nil

        tank =
          detail["タンク"] && detail["タンク"]["有"].present? || false

        planting_method =
          if detail["植付け方式"]
            detail["植付け方式"].detect{|k,v| v.present? }[0]
          end

        cabin =
          detail["キャビン"] && detail["キャビン"]["有"].present? || false

        fertilizer =
          detail["施肥機"] && detail["施肥機"]["有"].present? || false

        horse_power =
          detail["馬力"] ? detail["馬力"].to_i : nil

        drive_system =
          if detail["駆動方式"]
            detail["駆動方式"].detect{|k,v| v.present? }[0]
          end

        safety_frame =
          if detail["安全フレーム"]
            detail["安全フレーム"].detect{|k,v| v.present? }[0]
          end

        rotary =
          detail["ロータリ"] && detail["ロータリ"]["有"].present? || false

        maker_name = row[maker_name_index]
        model_name = row[model_name_index]
        sold_count = row[sold_count_index]

        from_year = row[from_year_index]
        to_year = row[to_year_index]

        from_year =
          if from_year.to_i > 20
            "19#{from_year}".to_i
          else
            "20#{from_year}".to_i
          end

       to_year =
          if to_year.to_i > 20
            "19#{to_year}".to_i
          else
            "20#{to_year}".to_i
          end

        max_price = row[max_price_index].to_i * 1000
        average_price = row[average_price_index].to_i * 1000
        min_price = row[min_price_index].to_i * 1000

        ItemMarketPrice.create!(
          category_name: category_name,
          sub_category_name: sub_category_name,
          area: area,
          maker_name: maker_name,
          model: model_name,
          sold_count: sold_count,
          from_year: from_year,
          to_year: to_year,
          max_price: max_price,
          average_price: average_price,
          min_price: min_price,
          detail_json: detail.to_json,
          number_of_thread: number_of_thread,
          tank: tank,
          planting_method: planting_method,
          cabin: cabin,
          fertilizer: fertilizer,
          horse_power: horse_power,
          drive_system: drive_system,
          safety_frame: safety_frame,
          rotary: rotary
        )
      end

      count_up_row_index
    end
  end

  private
    attr_reader :csv_file_path, :category_name, :sub_category_name, :area, :row_index, :maker_name_index, :model_name_index, :sold_count_index, :from_year_index, :to_year_index, :max_price_index, :average_price_index, :min_price_index, :detail_index_from, :detail_index_to, :detail_down, :detail_up

  def reset_row_index
    @row_index = 0
  end

  def count_up_row_index
    @row_index += 1
  end
end
