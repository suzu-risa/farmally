namespace :task do
  desc 'Execute task'
  task exec: :environment do
    # rails consoleで試すには記述量が多い場合, ここに書いて試す
    # sub_category_names = SubCategory.all.pluck(:name)
    # CSV.foreach('tmp/item_master_20181125.csv', headers: true) do |row|
    #   puts "#{row.to_s.chomp},#{Category.find(SubCategory.find_by(name: row['sub_category']).category_id).name}"
    # end
  end
end
