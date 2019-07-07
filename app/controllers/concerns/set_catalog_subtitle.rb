module SetCatalogSubtitle extend ActiveSupport::Concern

  included do
    before_action :set_subtitle
  end

  def set_subtitle
    @subtitle = {
        path: "/",
        title: "農機カタログ"
    }
  end
end
