class CommentsController < ApplicationController
  before_action :find_review, only: [:create, :destroy]
  before_action :find_comment, only: :destroy
  before_action :check_permission, only: :destroy

  def create
    if params[:comment].present?
      create_comment
    else
      create_reply_comment
    end
  end

  def destroy
    @review = comment.review
    if comment.destroy
      flash[:success] = t ".delete_success"
      redirect_to review
    else
      flash[:danger] = t ".delete_fail"
      redirect_to review
    end
  end

  private

  attr_reader :comment, :review

  def check_permission
    unless comment.user == current_user
      flash[:danger] = t ".not_permission"
      redirect_to review
    end
  end

  def find_review
    @review = Review.find_by id: params[:review_id]
  end

  def find_comment
    @comment = Comment.find_by id: params[:id]
  end

  def comments_params
    params.require(:comment).permit Comment::ATTRIBUTES_PARAMS
  end

  def reply_comment_params
    params.require(:reply_comment).permit Comment::ATTRIBUTES_PARAMS
  end

  def create_comment
    @comment = review.comments.new comments_params
    comment.user = current_user
    if comment.save
      flash[:success] = t ".comment_success"
      redirect_to review_path(params[:review_id])
    else
      flash[:danger] = t ".comment_fail"
      redirect_to review_path(params[:review_id])
    end
  end

  def create_reply_comment
    @comment = review.comments.new reply_comment_params
    comment.user = current_user
    comment.parent_id = params[:parent_comment_id]
    if comment.save
      flash[:success] = t ".comment_success"
      redirect_to review_path(params[:review_id])
    else
      flash[:danger] = t ".comment_fail"
      redirect_to review_path(params[:review_id])
    end
  end
end
