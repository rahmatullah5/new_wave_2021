# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ExceptionHandler
  before_action :authorize_request, except: :current_user

  private

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = Jwt::Authenticator.decode(header)
      @current_user = User.find(@decoded.try(:[], :user_id))
    rescue ActiveRecord::RecordNotFound => e
      render(json: { errors: e }, status: :unauthorized) && return
    rescue JWT::DecodeError => e
      render(json: { errors: e }, status: :unauthorized) && return
    end
  end

  def user_not_authorized(exception)
    render(json: exception, status: :unauthorized) && return
  end
end
