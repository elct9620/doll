# frozen_string_literal: true

module Doll
  module Event
    # Chatbot Event - Message
    # TODO: Should implement full feature for this class
    class Message
      attr_reader :user_id, :body

      def initialize(user_id, body)
        @user_id = user_id
        @body = body
      end
    end
  end
end
