require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Doll::Adapter::Facebook do
  let(:access_token) { 'ACCESS_TOKEN' }
  let(:secret_token) { 'SECRET_TOKEN' }
  let(:verify_token) { 'VERIFY_TOKEN' }

  let(:adapter) do
    Doll::Adapter::Facebook.new(
      access_token,
      secret_token,
      verify_token
    )
  end

  let(:raw_request) do
    Rack::MockRequest.env_for(
      'https://localhost:3000/facebook',
      request_options
    )
  end

  let(:request_options) { {} }
  let(:request) { Doll::Request.new(raw_request) }

  describe '#verify_token' do
    let(:request_options) do
      {
        params: {
          'hub.verify_token' => verify_token
        }
      }
    end

    it 'return true if valid' do
      res = adapter.verify_token(request)
      expect(res.first).to eq(200)
    end
  end

  describe '#verify_signature' do
    let(:request_options) do
      {
        :input => 'Hello World',
        'HTTP_X_HUB_SIGNATURE' =>
        'sha1=ba1294b712d4bb7cc1a1dbcbb0eceba4f133e3ca'
      }
    end

    it 'return true if valid' do
      result = adapter.verify_signature(request)
      expect(result).to be_truthy
    end
  end

  describe '#reply' do
    let(:params) do
      {
        recipient: {
          id: '12345678'
        }
      }
    end

    let(:message) { Doll::Message::Text.new('Example') }

    it 'can send reply text message' do
      expect(adapter).to receive(:send).with(
        params.dup.merge(message: { text: message.text })
      )
      adapter.reply(params, message)
    end
  end

  describe '#process' do
    let(:body) do
      {
        entry: [
          {
            messaging: [
              {
                sender: {
                  id: '12345678'
                },
                message: {
                  text: 'Example'
                }
              }
            ]
          }
        ]
      }.to_json
    end

    it 'convert json to message object' do
      message = adapter.process(body).first
      expect(message[:text]).to eq('Example')
    end
  end
end
