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
      @item = Item.find(params[:item_id])
      @sale_item = @item.sale_items.build(sale_item_template_id: @item.sale_item_template.id)
      @property_template = @sale_item.sale_item_template

      super
    end

    def show
      @inquiry = SaleItem.find(params[:id]).inquiries.build

      super
    end

    def edit
      @sale_item = SaleItem.find(params[:id])
      @items = Item.all
      @sale_item_templates = SaleItemTemplate.all
      @property_template = @sale_item.sale_item_template

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

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   SaleItem.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
    #
    private

    def find_property_template(id)
      SaleItemTemplate.find(id)
    end

    def resource_params
      params.require(resource_class.model_name.param_key).
        permit(:item_id,
               :name,
               :price,
               :used_hours,
               :year,
               :horse_power,
               :prefecture_code,
               :sold_at,
               :sale_item_template_id,
               :status,
               detail_json: { properties: {} },
               images: [])
    end
  end
end
