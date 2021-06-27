# frozen_string_literal: true

module Users
  module Posts
    class CommentsController < ActionController::API
      before_action :check_user_policy
      before_action :set_post
      before_action :set_comment, only: %i[show update destroy]

      # GET /comments
      def index
        @comments = @post.comments

        render json: @comments
      end

      # GET /comments/1
      def show
        render json: @comment
      end

      # POST /comments
      def create
        @comment = @current_user.comments.new(comment_params)

        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /comments/1
      def update
        if @comment.update(comment_params)
          render json: @comment
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      # DELETE /comments/1
      def destroy
        @comment.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_comment
        @comment = @post.comments.find(params[:id])
      end

      def set_post
        @post = @current_user.posts.find(params[:post_id])
      end

      # Only allow a trusted parameter "white list" through.
      def comment_params
        params.permit(:user_id, :post_id, :content)
      end

      def check_user_policy
        render json: "You're unauthorized", status: :unauthorized if params[:user_id] != @current_user.id
      end
    end
  end
end
