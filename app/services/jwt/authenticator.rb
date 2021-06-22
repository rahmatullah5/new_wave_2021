# frozen_string_literal: true

module Jwt
  class Authenticator
    def self.encode(payload, exp = 24.days.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, ENV['SECRET_KEY_BASE'])
    end

    def self.decode(token)
      decoded = JWT.decode(token, ENV['SECRET_KEY_BASE'])[0]
      HashWithIndifferentAccess.new decoded
    end
  end
end
