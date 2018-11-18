module Admin
  class Sale::PropertyTemplatesController < Admin::ApplicationController
    before_action :default_params
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Category.
    #     page(params[:page]).
    #     per(10)
    # end
    def new
      @property_template = ::Sale::PropertyTemplate.new
      @property_template.properties.build
      super
    end

    def edit
      @property_template = find_resource(params[:id])
      super
    end

    def create
      super
    end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    private

    def default_params
      params[:order] ||= 'id'
      params[:direction] ||= 'asc'
    end

    def resource_params
      params.require(resource_class.model_name.param_key).
        permit(:category_id, properties_attributes: [:name, :_destroy, :id])
    end
  end
end
