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
      @property_template = @sale_item.sale_property_template

      render locals: {
        page: Administrate::Page::Form.new(dashboard, requested_resource),
      }
    end

    def property_list
      @sale_item = SaleItem.find_by(id: params[:id])
      sale_property_template_id = params[:sale_property_template_id].to_i

      @sale_item_properties =
        if @sale_item && @sale_item.sale_property_template_id == sale_property_template_id
          @sale_item.sale_item_properties
        else
          property_template = find_property_template(sale_property_template_id)

          property_template.property_ids.map do |sale_property_id|
            SaleItemProperty.new(sale_property_id: sale_property_id)
          end
        end
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
