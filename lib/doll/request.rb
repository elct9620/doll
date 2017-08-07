# forzen_string_literal: true

module Doll
  # API Request Object
  class Request < Rack::Request
    ADAPTER_PATTERN = %r{^\/(?<adapter>[^\/.]+)?.*}

    # TODO: Add support for multiple chatbot
    attr_reader :adapter

    def initialize(env)
      super

      load_adapter
    end

    def support?
      Doll.config.adapter_loaded?(adapter)
    end

    protected

    def load_adapter
      matchers = ADAPTER_PATTERN.match(path_info)
      @adapter = matchers[:adapter]&.to_sym
    end
  end
end
