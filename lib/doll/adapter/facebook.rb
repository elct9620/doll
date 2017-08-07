# frozen_string_literal: true

# TODO: Create doll-adapter-facebook gem for this
module Doll
  module Adapter
    # The base adapter
    class Facebook < Base
      def initialize(access_token, secret_token, verify_token)
        @name = :facebook
        @access_token = access_token
        @secret_token = secret_token
        @verify_token = verify_token
      end

      def process(body)
        parsed_body = JSON.parse(body, symbolize_names: true)
        # TODO: Improve parser
        parsed_body[:entry].map do |entry|
          entry[:messaging].map do |message|
            next if message.fetch(:message, {}).fetch(:text).nil?
            # TODO: Build parameter or event
            build_parameter(message)
          end
        end.flatten.compact
      end

      def verify_token(request)
        token = request.params['hub.verify_token']
        return Response.plain(request.params['hub.challenge']) if @verify_token == token
        Response.plain('Verify token is invalid', 403)
      end

      def verify_signature(request)
        signature = request.env['HTTP_X_HUB_SIGNATURE'].to_s
        body = request.body.read
        request.body.rewind
        Rack::Utils.secure_compare(signature, signature_for(body))
      end

      def reply(params, message)
        # TODO: Deal with send error
        send(
          recipient: { id: params[:recipient][:id] },
          message: { text: message.text }
        )
      end

      protected

      def build_parameter(message)
        Parameter[
          recipient: {
            id: message[:sender][:id]
          },
          text: message[:message][:text]
        ]
      end

      def signature_for(string)
        format('sha1=%s'.freeze, generate_hmac(string))
      end

      def generate_hmac(content)
        OpenSSL::HMAC.hexdigest('sha1'.freeze,
                                @secret_token,
                                content)
      end

      def send(body)
        uri = URI('https://graph.facebook.com/v2.6/me/messages')
        uri.query = URI.encode_www_form(access_token: @access_token)

        request = Net::HTTP::Post.new(uri.request_uri)
        request['Content-Type'] = 'application/json'
        request.body = body.to_json

        Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
          http.request(request)
        end
      end
    end
  end
end
