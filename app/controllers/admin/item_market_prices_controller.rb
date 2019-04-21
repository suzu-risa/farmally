module Admin
  class ItemMarketPricesController < Admin::ApplicationController
    before_action :default_params
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = ItemMarketPrice.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   ItemMarketPrice.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
    def default_params
      params[:order] ||= "model"
      params[:direction] ||= "asc"
    end
  end
end
