class ReviewCommentsController < ApplicationController
  def create
    ReviewComment.create!(review_comment_params)
    item_id = Review.find(review_comment_params[:review_id]).item_id
    redirect_to item_path(item_id), flash: { success: 'コメントを投稿しました。承認されるまでお待ちください' }
  rescue ActiveRecord::RecordInvalid => e
    item_id = Review.find(review_comment_params[:review_id]).item_id
    @item = Item.find(item_id)
    @review = @item.reviews.build
    @reviews = Review.where(item: @item, approved: true)
    @title = @item.model
    @breadcrumb = breadcrumb(item: @item)
    flash.now[:danger] = e.record.errors.full_messages.join('<br />').html_safe
    render template: 'items/show', status: :unprocessable_entity
  end

  private

  def review_comment_params
    params.require(:review_comment).permit(:review_id, :content)
  end
end
