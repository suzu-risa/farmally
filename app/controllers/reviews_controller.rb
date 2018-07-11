class ReviewsController < ApplicationController
  def create
    Review.create!(review_params)
    # TODO: リダイレクト先変える
    redirect_to root_path
  end

  private

  def review_params
    params.require(:review).permit(:item_id, :content, :star, :status, :purchase_price, :picture)
  end
end
