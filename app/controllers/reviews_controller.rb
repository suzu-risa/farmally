class ReviewsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
    @review = @item.reviews.build
  end

  def create
    Review.create!(review_params)
    redirect_to item_path(review_params[:item_id]), flash: { success: '口コミを投稿しました。承認されるまでお待ちください' }
  rescue ActiveRecord::RecordInvalid => e
    @item = Item.find(review_params[:item_id])
    @review = e.record
    flash.now[:danger] = e.record.errors.full_messages.join('<br />').html_safe
    render template: 'reviews/new', status: :unprocessable_entity
  end

  def likes
    review = Review.find(params[:id])
    review.increment!(:like_count)
    redirect_to item_path(review.item_id), flash: { success: 'いいねしました' }
  end

  private

  def review_params
    params.require(:review).permit(:item_id, :name, :content, :star, :status, :purchase_price, :picture)
  end
end
