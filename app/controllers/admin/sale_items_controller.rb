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
      @items = Item.all
      @sale_property_templates = ::Sale::PropertyTemplate.all
      @property_template = @sale_property_templates.first

      super
    end

    def show
      @inquiry = SaleItem.find(params[:id]).inquiries.build

      super
    end

    def edit
      @sale_item = SaleItem.find(params[:id])
      @items = Item.all
      @sale_property_templates = ::Sale::PropertyTemplate.all
      @property_template = @sale_item.sale_property_template

      render locals: {
        page: Administrate::Page::Form.new(dashboard, requested_resource),
      }
    end

    def update
      if requested_resource.update(resource_params)
        redirect_to(
          [namespace, requested_resource],
          notice: translate_with_resource("update.success"),
        )
      else
        render :edit, locals: {
          page: Administrate::Page::Form.new(dashboard, requested_resource),
        }
      end
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
        permit(:item_id,
               :price,
               :sale_property_template_id,
               detail_json: { properties: {} },
               images: [])
    end
  end
end
