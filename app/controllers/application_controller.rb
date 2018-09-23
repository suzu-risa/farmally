class ApplicationController < ActionController::Base
  # FIXME: ApplicationHelperに移すべき
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
    end
    if category.present?
      breadcrumb = breadcrumb + [
        {
          name: category.name,
          path: "/categories/#{category.code}"
        }
      ]
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
end
