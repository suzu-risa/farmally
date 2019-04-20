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
        @category_name = row[1]
      when @sub_category_name_row_index
        @sub_category_name = row[1]
      when @area_row_index
        @area = row[1]
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
        maker_name = row[maker_name_index]
        model_name = row[model_name_index]
        sold_count = row[sold_count_index]

        from_year = row[from_year_index]
        to_year = row[to_year_index]

        max_price = row[max_price_index]
        average_price = row[average_price_index]
        min_price = row[min_price_index]

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
