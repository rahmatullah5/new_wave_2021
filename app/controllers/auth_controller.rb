# frozen_string_literal: true

class AuthController < ApplicationController
  skip_before_action :authorize_request
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      render json: { token: Jwt::Authenticator.encode(user_id: user.id) }, status: :ok
    else
      render json: {}, status: :unauthorized
    end
  end
end
