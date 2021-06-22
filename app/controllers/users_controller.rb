# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:create]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @current_user
  end

  # POST /users
  def create
    @current_user = User.new(user_params)

    if @current_user.save
      render json: @current_user, status: :created, location: @current_user
    else
      render json: @current_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @current_user.update(user_params)
      render json: @current_user
    else
      render json: @current_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    current_user.destroy
  end

  private

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.permit(:name, :email, :password)
  end
end
