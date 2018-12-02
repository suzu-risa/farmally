module Admin
  class SaleItemTemplatesController < Admin::ApplicationController
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
      @property_template = SaleItemTemplate.new
      @categories = Category.all
      super
    end

    def edit
      @property_template = find_resource(params[:id])
      @categories = Category.all
      super
    end

    def create
      resource = resource_class.new(resource_params)
      authorize_resource(resource)

      if resource.save
        redirect_to(
          [namespace, resource],
          notice: translate_with_resource("create.success"),
        )
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }
      end
    end

    def detail_file
      property_template = find_resource(params[:id])
      file = property_template.detail_file

      send_file(file.path, :filename => "#{property_template.category.name}の出品商品テンプレート.csv")
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
        permit(:category_id, :detail_file)
    end
  end
end
