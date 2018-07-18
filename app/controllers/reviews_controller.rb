class ReviewsController < ApplicationController
  def create
    Review.create!(review_params)
    redirect_to item_path(review_params[:item_id]), flash: { success: 'レビューを投稿しました。承認されるまでお待ちください' }
  rescue ActiveRecord::RecordInvalid => e
    @item = Item.find(review_params[:item_id])
    @review = e.record
    @reviews = Review.where(item: @item, approved: true)
    @title = @item.model
    @breadcrumb = [
      {
        name: 'トップ',
        path: '/'
      },
      {
        name: @item.category.name,
        path: "/categories/#{@item.category.code}"
      },
      {
        name: @item.maker.name,
        path: "/makers/#{@item.maker.code}"
      },
      {
        name: @item.model,
        path: "/items/#{@item.id}"
      }
    ]
    flash.now[:danger] = e.record.errors.full_messages.join('<br />').html_safe
    render template: 'items/show', status: :unprocessable_entity
  end

  private

  def review_params
    params.require(:review).permit(:item_id, :content, :star, :status, :purchase_price, :picture)
  end
end
