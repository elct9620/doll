# frozen_string_literal: true

module Doll
  # Chatbot Configuration
  class Config
    attr_reader :adapters, :middlewares

    def initialize
      @adapters = {}
      @middlewares = []
    end

    def adapter(adapter)
      @adapters[adapter.name.to_sym] = adapter
    end

    def adapter_loaded?(name)
      return false if name.nil?
      @adapters.key?(name.to_sym)
    end

    def use(middleware)
      @middlewares.push(middleware)
    end
  end
end
