# frozen_string_literal: true

module Doll
  # Chatbot Base Controller
  class Dialog
    def initialize(context, adapter)
      # TODO: Use parameter class
      @params = context
      @params[:adapter] = adapter

      setup(context)
    end

    def process
      raise NotImplementedError, "Dialog's process method should be implemented"
    end

    private

    attr_reader :params

    def setup(context)
      # TODO: Support all types event
      # @params[:text] = context.body.text
    end
  end
end
