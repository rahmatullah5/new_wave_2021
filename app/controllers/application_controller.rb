# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ExceptionHandler
  before_action :authorize_request, except: :current_user

  def check_user_policy
    render json: "You're unauthorized", status: :unauthorized if params[:user_id].to_i != @current_user.id
  end

  private

  def authorize_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    begin
      @decoded = Jwt::Authenticator.decode(header)
      @current_user = User.find(@decoded.try(:[], :user_id))
    rescue ActiveRecord::RecordNotFound => e
      render(json: {errors: e}, status: :unauthorized) && return
    rescue JWT::DecodeError => e
      render(json: {errors: e}, status: :unauthorized) && return
    end
  end

  def user_not_authorized(exception)
    render(json: exception, status: :unauthorized) && return
  end
end
