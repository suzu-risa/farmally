module Admin
  module SaleItems
    class ImagesController < Admin::ApplicationController
      def create
        sale_item = find_sale_item(params[:sale_item_id])

        ActiveRecord::Base.transaction do
          params[:images].each do |image|
            position =
              if last_position = sale_item.sale_item_images.last.try(:position)
                last_position + 1
              else
                0
              end

            sale_item.sale_item_images.create!(
              image: image,
              position: position
            )
          end
        end

        flash[:notice] = "画像を登録しました"

        redirect_to edit_admin_sale_item_path(sale_item)
      rescue => e
        flash[:alert] = "画像の登録に失敗しました。\n#{e.message}"

        redirect_to edit_admin_sale_item_path(sale_item)
      end

      def bulk_update
        sale_item = find_sale_item(params[:sale_item_id])

        params["sale_item_images"].each do |image_params|
          sale_item.sale_item_images.find(image_params[:id]).update(position: image_params[:position])
        end

        flash[:notice] = "画像の並び順を更新しました"

        redirect_to edit_admin_sale_item_path(sale_item)
      end

      def destroy
        sale_item = find_sale_item(params[:sale_item_id])

        if sale_item.sale_item_images.find(params[:id]).destroy
          flash[:notice] = "画像を削除しました"
        else
          flash[:alert] = "画像の削除に失敗しました"
        end

        redirect_to edit_admin_sale_item_path(sale_item)
      end

      private

        def find_sale_item(sale_item_id)
          SaleItem.find(sale_item_id)
        end
    end
  end
end
