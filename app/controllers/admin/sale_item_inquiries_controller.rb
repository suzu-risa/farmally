module Admin
  class SaleItemInquiriesController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = SaleItemInquiry.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   SaleItemInquiry.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
    #
    def new
      resource = find_sale_item(params[:sale_item_id]).inquiries.build
      authorize_resource(resource)
      render locals: {
        page: Administrate::Page::Form.new(dashboard, resource),
      }
    end

    def create
      resource = find_sale_item(params[:sale_item_id]).inquiries.build(resource_params)
      authorize_resource(resource)
      if resource.save
        redirect_to(
          admin_sale_item_inquiry_path(resource.id, sale_item_id: resource.sale_item_id),
          notice: translate_with_resource("create.success"),
        )
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }
      end
    end

    private

      def find_sale_item(sale_item_id)
        SaleItem.find(sale_item_id)
      end
  end
end
