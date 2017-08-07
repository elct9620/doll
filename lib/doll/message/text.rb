# frozen_string_literal: true

module Doll
  module Message
    # Chatbot Message - Text
    class Text
      attr_reader :text

      def initialize(text)
        @text = text
      end
    end
  end
end
