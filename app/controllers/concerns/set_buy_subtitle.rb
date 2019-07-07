module SetBuySubtitle extend ActiveSupport::Concern

  included do
    before_action :set_subtitle
  end

  def set_subtitle
    @subtitle = {
        path: "/",
        title: "農機販売"
    }
  end
end
