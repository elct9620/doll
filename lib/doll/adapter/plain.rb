# frozen_string_literal: true

module Doll
  module Adapter
    # The base adapter
    class Plain < Base
      def initialize
        @name = :plain
      end

      def process(body)
        [
          Event::Message.new(
            'Unknown',
            Message::Text.new(body)
          )
        ]
      end

      def verify_signature(_request)
        true
      end

      def reply(_event, message)
        # TODO: Output to somewhere
        puts 'Chatbot:'
        puts message.text
      end
    end
  end
end
