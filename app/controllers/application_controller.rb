class ApplicationController < ActionController::Base
  before_action :read_master_data

  # FIXME: ApplicationHelperに移すべき
  def breadcrumb(item: nil, category: nil, sub_category: nil, maker: nil)
    breadcrumb = [
      {
        name: 'トップ',
        path: '/'
      }
    ]
    if item.present?
      return breadcrumb + [
        {
          name: item.category.name,
          path: "/categories/#{item.category.code}"
        },
        {
          name: item.sub_category.name,
          path: "/categories/#{item.category.code}/#{item.sub_category.code}"
        },
        {
          name: item.maker.name,
          path: "/makers/#{item.maker.code}"
        },
        {
          name: item.model,
          path: "/items/#{item.id}"
        }
      ]
    end
    if category.present?
      breadcrumb = breadcrumb + [
        {
          name: category.name,
          path: "/categories/#{category.code}"
        }
      ]
      if sub_category.present?
        breadcrumb = breadcrumb + [
          {
            name: sub_category.name,
            path: "/categories/#{category.code}/#{sub_category.code}"
          }
        ]
      end
    end
    if maker.present?
      breadcrumb = breadcrumb + [
        {
          name: maker.name,
          path: "/makers/#{maker.code}"
        }
      ]
    end
    breadcrumb
  end

  private

  def read_master_data
    @master_categories = Rails.cache.fetch('master-category-data', expires_in: 6.hours) do
      Category.all.pluck(:id, :code, :name).map { |c| { id: c[0], code: c[1], name: c[2] } }.to_json
    end
    @master_sub_categories = Rails.cache.fetch('master-sub-category-data', expires_in: 6.hours) do
      SubCategory.all.pluck(:code, :name, :category_id).map do |c|
        { code: c[0], name: c[1], category_id: c[2] }
      end.group_by { |c| c[:category_id] }.to_json
    end
    @master_makers = Rails.cache.fetch('master-maker-data', expires_in: 6.hours) do
      Maker.all.pluck(:code, :name).map { |m| { code: m[0], name: m[1] } }.to_json
    end
  end
end
