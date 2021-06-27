# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show update destroy]
  before_action :set_post

  # GET /comments
  def index
    @comments = @post.comments.all

    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.permit(:user_id, :post_id, :content)
  end
end
