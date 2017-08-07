# frozen_string_literal: true

module Doll
  # API Response Object
  class Response < Rack::Response
    class << self
      def ok(message = 'OK')
        new(200, message: message).finish
      end

      def error(code, reason, status = 500)
        new(status, error: { code: code, message: reason }).finish
      end

      def not_found(reason)
        new(404, error: { message: reason })
      end

      def api_status
        new(200, version: Doll::VERSION).finish
      end
    end

    def initialize(status, body = {})
      super()
      self.status = status
      self.body = [body.to_json]

      headers['Content-Type'] = 'application/json'
    end
  end
end
