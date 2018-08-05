class ApplicationController < ActionController::Base
  def breadcrumb(item: nil, category: nil, maker: nil)
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
          name: item.maker.name,
          path: "/makers/#{item.maker.code}"
        },
        {
          name: item.model,
          path: "/items/#{item.id}"
        }
      ]
    elsif category.present? && maker.present?
      return breadcrumb + [
        {
          name: category.name,
          path: "/categories/#{category.code}"
        },
        {
          name: maker.name,
          path: "/makers/#{maker.code}"
        }
      ]
    elsif category.present?
      return breadcrumb + [
        {
          name: category.name,
          path: "/categories/#{category.code}"
        }
      ]
    elsif maker.present?
      return breadcrumb + [
        {
          name: maker.name,
          path: "/makers/#{maker.code}"
        }
      ]
    end
    breadcrumb
  end
end
