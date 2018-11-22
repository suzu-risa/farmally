module Admin
  module SaleItems
    class ImagesController < ActionController::Base
      def create
        @sale_item = SaleItem.find(params[:sale_item_id])

        if @sale_item.update(sale_item_params)
          flash[:notice] = "画像を登録しました"
        else
          flash[:alert] = "画像の登録に失敗しました"
        end

        redirect_to edit_admin_sale_item_path(@sale_item)
      end

      def update

      end

      def destroy
        if @sale_item.update(sale_item_params)
        else
        end
      end

      private

      def sale_item_params
        params.require(:sale_item).permit(images: [])
      end
    end
  end
end
