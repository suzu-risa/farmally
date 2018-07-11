class ReviewsController < ApplicationController
  def create
    Review.create!(review_params)
    redirect_to item_path(review_params[:item_id])
  end

  private

  def review_params
    params.require(:review).permit(:item_id, :content, :star, :status, :purchase_price, :picture)
  end
end
