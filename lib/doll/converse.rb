# frozen_string_literal: true

module Doll
  # The router for chatbot
  class Converse
    def initialize
      @routes = []
      @not_found = nil
    end

    def not_found(_options = {}, &block)
      # TODO: Support options support
      @not_found = block if block_given?
    end

    def dispatch(event, adapter)
      # TODO: Support for not found
      reply = Message::Text.new(@not_found.call)
      Doll.config.adapters[adapter].reply(event, reply)
    end
  end
end
