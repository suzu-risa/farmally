crumb :root do
  link "トップ", root_path
end

crumb :maker do |maker|
  parent :root

  link maker.name, maker_path(maker.code)
end

crumb :category do |category|
  parent :root
  link category.name, category_path(category.code)
end

crumb :sub_category do |sub_category|
  parent :category, sub_category.category
  link sub_category.name,
       sub_category_category_path(
         code: sub_category.category.code,
         sub_code: sub_category.code
       )
end

crumb :item do |item|
  parent :sub_category, item.sub_category
  link item.model, item_path(item)
end

crumb :sale_items do |sale_items|
  parent :root

  link "出品商品一覧", sale_items_path
end

crumb :sold_items do |sale_items|
  parent :root

  link "買取実績一覧", sold_items_path
end

crumb :sale_item do |sale_item|
  if sale_item.sold?
    parent :sold_items
  else
    parent :sale_items
  end

  link "#{sale_item.name}", item_sale_item_path(sale_item)
end


# 買取
crumb :sell_root do
  link "買取トップ", "/sell"
end

# user#index
crumb :sell_categories do
  link "買取カテゴリ", "/sell/categories"
  parent :sell_root
end

crumb :sell_category do |category|
  link category[:title], "/sell/categories/#{category[:slug]}"
  parent :sell_categories
end

crumb :sell_makers do
  link "買取メーカー", "/sell/makers"
  parent :sell_root
end

crumb :sell_maker do |maker|
  link maker[:title], "/sell/makers/#{maker[:slug]}"
  parent :sell_makers
end

# 購入
crumb :buy_root do
  link "購入トップ", "/buy"
end

# 問い合わせ
crumb :inquiry_root do
  link "問い合わせトップ", "/inquiry"
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
