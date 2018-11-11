module Admin
  class SaleItemsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = SaleItem.
    #     page(params[:page]).
    #     per(10)
    # end
    #
    def new
      @sale_item = SaleItem.new
      @property_template = ::Sale::PropertyTemplate.first

      @property_template.property_ids.each do |sale_property_id|
        @sale_item.sale_item_properties.build(
          sale_property_id: sale_property_id
        )
      end

      super
    end

    def edit
      @sale_item = SaleItem.find(params[:id])
      @property_template = ::Sale::PropertyTemplate.first

      render locals: {
        page: Administrate::Page::Form.new(dashboard, requested_resource),
      }
    end

    def property_list
      @proerty_template = find_property_template(params[:template_id])
    end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   SaleItem.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
    #
    private

    def find_property_template(id)
      ::Sale::PropertyTemplate.find(id)
    end

    def resource_params
      params.require(resource_class.model_name.param_key).
        permit(:item_id, :price, :sale_property_template_id, sale_item_property_attributes: [:sale_property_id, :value])
    end
  end
end
