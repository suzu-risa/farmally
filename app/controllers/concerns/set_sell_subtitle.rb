module SetSellSubtitle extend ActiveSupport::Concern

  included do
    before_action :set_subtitle
  end

  def set_subtitle
    @subtitle = {
        path: "/sell",
        title: "農機買取"
    }
  end
end
