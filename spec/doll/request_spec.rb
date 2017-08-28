require 'spec_helper'

RSpec.describe Doll::Request do
  let(:adapter) { :plain }

  let(:env) do
    Rack::MockRequest.env_for(
      "https://localhost:3000/#{adapter}"
    )
  end

  let(:request) { Doll::Request.new(env) }

  describe '#adapter' do
    it 'equals request path' do
      expect(request.adapter).to eq(adapter)
    end
  end

  describe '#support?' do
    before do
      allow_any_instance_of(Doll::Config)
        .to receive(:adapter_loaded?).with(adapter).and_return(true)
    end

    it 'return ture if adapter is loaded' do
      expect(request.support?).to be_truthy
    end
  end
end
