# frozen_string_literal: true

module Doll
  # The Chatbot API server
  class Server
    class << self
      attr_reader :instance

      LOCK = Mutex.new

      def init
        LOCK.synchronize { compile } unless instance
        instance
      end

      def compile
        @instance ||= new
      end

      def call(env)
        init
        instance.call(env)
      end
    end

    def call(env)
      request = Request.new(env)
      res = handle_by_chatbot(request)
      return res unless res.nil?
      # TODO: More Doll information
      Response.api_status
    end

    protected

    def handle_by_chatbot(request)
      # TODO: Improve error handler
      return Response.not_found('Adapter not found.') unless request.support?
      return verify_token(request) if request.get?
      Doll.config.adapters[request.adapter].handle(request)
    end

    def verify_token(request)
      Doll.config.adapters[request.adapter].verify_token(request)
    end
  end
end
