module Admin
  module SaleItems
    class ImagesController < Admin::ApplicationController
      def create
        sale_item = find_sale_item(params[:sale_item_id])

        if sale_item.update(sale_item_params)
          flash[:notice] = "画像を登録しました"
        else
          flash[:alert] = "画像の登録に失敗しました"
        end

        redirect_to edit_admin_sale_item_path(sale_item)
      end

      def destroy
        sale_item = find_sale_item(params[:sale_item_id])

        if sale_item.images.find(params[:id]).destroy
          flash[:notice] = "画像を削除しました"
        else
          flash[:alert] = "画像の削除に失敗しました"
        end

        redirect_to edit_admin_sale_item_path(sale_item)
      end

      private

      def sale_item_params
        params.require(:sale_item).permit(images: [])
      end

      def find_sale_item(sale_item_id)
        SaleItem.find(sale_item_id)
      end
    end
  end
end
