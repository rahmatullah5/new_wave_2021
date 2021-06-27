# frozen_string_literal: true

module Users
  class PostsController < ApplicationController
    before_action :check_user_policy
    before_action :set_post, only: %i[show update destroy]
    # GET /posts
    def index
      @posts = @current_user.posts

      render json: @posts
    end

    # GET /posts/1
    def show
      render json: @post
    end

    # POST /posts
    def create
      @post = @current_user.posts.new(post_params)

      if @post.save
        render json: @post, status: :created, location: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /posts/1
    def update
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    # DELETE /posts/1
    def destroy
      @post.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = @current_user.posts.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.permit(:user_id, :title, :content)
    end
  end
end
