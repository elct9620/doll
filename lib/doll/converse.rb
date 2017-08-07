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

    def match(rule, options = {})
      @routes.push(Match.new(rule, to: options[:to]))
    end

    # TODO: Add user session support
    def dispatch(params, adapter)
      selected = @routes.each do |route|
        break route if route.match?(params[:text])
      end
      reply = unless selected.is_a?(Array)
                selected.dialog.new(params, adapter).process
              else
                Message::Text.new(@not_found.call)
              end
      Doll.config.adapters[adapter].reply(params, reply)
    end

    # :nodoc:
    class Match
      def initialize(rule, to:)
        @rule = rule
        @to = to.to_s
      end

      def match?(input)
        @rule.match?(input)
      end

      def dialog
        Kernel.const_get("#{@to.capitalize}::StartDialog")
      end
    end
  end
end
