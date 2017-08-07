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
        return Response.error(0, 'Verify failed') unless verify(request)
        body = request.body.read
        # TODO: Add support for job scheduler
        # TODO: Handle thread errors
        Thread.abort_on_exception = true
        Thread.new { Doll.dispatch(process(body), name) }
        Response.ok
      end

      def process(_body)
        raise NotImplementedError,
              "Adapter's process method should be implemented"
      end

      def verify(_request)
        raise NotImplementedError,
              "Adapter's verify method should be implemented"
      end

      def reply(_event, _message)
        raise NotImplementedError,
              "Adapter's reply method should be implemented"
      end
    end
  end
end
