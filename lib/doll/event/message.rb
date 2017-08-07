# frozen_string_literal: true

module Doll
  module Event
    # Chatbot Event - Message
    # TODO: Should implement full feature for this class
    class Message
      attr_reader :body

      def initialize(body)
        @body = body
      end
    end
  end
end
