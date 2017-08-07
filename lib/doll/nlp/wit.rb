# frozen_string_literal: true

module Doll
  module NLP
    # The NLP Service from Facebook
    class Wit
      HOST = 'https://api.wit.ai'.freeze
      VERSION = '20170725'.freeze

      def initialize(token)
        @token = token
      end

      def call(params)
        return params if params[:text].nil?
        intent = query(params[:text]).dig(:entities, :intent).first[:value]
        params[:intent] = intent if intent
        params
      end

      private

      def query(string)
        uri = URI("#{HOST}/message")
        uri.query = URI.encode_www_form(q: string, n: 5)

        request = Net::HTTP::Get.new(uri.request_uri)
        request['Authorization'] = "Bearer #{@token}"
        request['Accept'] = "application/vnd.wit.#{VERSION}+json"
        request['Content-Type'] = 'application/json'

        result = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
          http.request(request)
        end

        JSON.parse(result.body, symbolize_names: true)
      end
    end
  end
end
