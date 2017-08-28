require 'spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Doll::Response do
  context 'Class Methods' do
    let(:res) { Doll::Response.ok }
    let(:json) { JSON.parse(res.last.body.first) }

    describe '.ok' do
      it 'return success response' do
        res = Doll::Response.ok
        expect(res.first).to eq(200)
      end

      context 'message' do
        let(:res) { Doll::Response.ok('Done') }
        it 'can change it' do
          expect(json['message']).to eq('Done')
        end
      end
    end

    describe '.api_status' do
      let(:res) { Doll::Response.api_status }

      it 'return current version' do
        expect(json['version']).to eq(Doll::VERSION)
      end
    end

    describe '.plain' do
      let(:res) { Doll::Response.plain('Hello World') }

      it 'response plain text' do
        header = res.drop(1).first
        expect(header['Content-Type']).to eq('text/plain')
      end

      context 'status' do
        let(:res) { Doll::Response.plain('Not Found', 404) }

        it 'can be changed' do
          status = res.first
          expect(status).to be(404)
        end
      end
    end

    describe '.not_found' do
      let(:reason) { 'No support adapter' }
      let(:res) { Doll::Response.not_found(reason) }

      it 'response with error reason' do
        expect(json['error']['message']).to eq(reason)
      end
    end

    describe '.error' do
      let(:code) { 100 }
      let(:reason) { 'Adapter not configured' }
      let(:status) { 500 }
      let(:res) { Doll::Response.error(code, reason, status) }

      it 'response with error code' do
        expect(json['error']['code']).to eq(code)
      end

      it 'response with error reason' do
        expect(json['error']['message']).to eq(reason)
      end

      context 'status' do
        let(:status) { 503 }

        it 'can be changed' do
          expect(res.first).to eq(status)
        end
      end
    end
  end
end
