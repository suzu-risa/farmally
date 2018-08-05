class ReviewsController < ApplicationController
  def create
    Review.create!(review_params)
    redirect_to item_path(review_params[:item_id]), flash: { success: '口コミを投稿しました。承認されるまでお待ちください' }
  rescue ActiveRecord::RecordInvalid => e
    @item = Item.find(review_params[:item_id])
    @review = e.record
    @reviews = Review.where(item: @item, approved: true)
    @title = @item.model
    @breadcrumb = breadcrumb(item: @item)
    flash.now[:danger] = e.record.errors.full_messages.join('<br />').html_safe
    render template: 'items/show', status: :unprocessable_entity
  end

  def likes
    review = Review.find(params[:id])
    review.increment!(:like_count)
    redirect_to item_path(review.item_id), flash: { success: 'いいねしました' }
  end

  private

  def review_params
    params.require(:review).permit(:item_id, :content, :star, :status, :purchase_price, :picture)
  end
end
