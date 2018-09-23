class ReviewCommentsController < ApplicationController
  def new
    @review = Review.find(params[:review_id])
    @review_comment = @review.review_comments.build
    @item = @review.item
  end

  def create
    ReviewComment.create!(review_comment_params)
    item_id = Review.find(review_comment_params[:review_id]).item_id
    redirect_to item_path(item_id), flash: { success: 'コメントを投稿しました。承認されるまでお待ちください' }
  rescue ActiveRecord::RecordInvalid => e
    @review = Review.find(review_comment_params[:review_id])
    @item = @review.item
    @review_comment = e.record
    flash.now[:danger] = e.record.errors.full_messages.join('<br />').html_safe
    render template: 'review_comments/new', status: :unprocessable_entity
  end

  def likes
    comment = ReviewComment.find(params[:id])
    comment.increment!(:like_count)
    redirect_to item_path(comment.review.item_id), flash: { success: 'いいねしました' }
  end

  private

  def review_comment_params
    params.require(:review_comment).permit(:review_id, :name, :content)
  end
end
