# frozen_string_literal: true

module Doll
  module Adapter
    # The base adapter
    class Base
      attr_reader :name

      def initialize
        @name = :base
      end

      def handle(request)
        # TODO: Specify Error code when verify failed
        return Response.error(0, 'Failed') unless verify_signature(request)
        body = request.body.read
        dispatch(process(body))
        Response.ok
      end

      def process(_body)
        raise NotImplementedError,
              "Adapter's process method should be implemented"
      end

      def verify_token(_request)
        Response.ok
      end

      def verify_signature(_request)
        raise NotImplementedError,
              "Adapter's verify_signature method should be implemented"
      end

      def reply(_event, _message)
        raise NotImplementedError,
              "Adapter's reply method should be implemented"
      end

      private

      def dispatch(events)
        # TODO: Add support for job scheduler
        # TODO: Handle thread errors
        Thread.abort_on_exception = true
        events.each do |event|
          # TODO: Improve apply middleware
          event = Doll.config
                      .middlewares
                      .reduce(event) { |p, fn| fn.call(p) }
          Thread.new { Doll.dispatch(event, name) }
        end
      end
    end
  end
end
