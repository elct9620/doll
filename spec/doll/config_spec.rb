require 'spec_helper'

RSpec.describe Doll::Config do
  let(:config) { Doll::Config.new }

  describe 'adapter' do
    it 'can add adapter' do
      config.adapter Doll::Adapter::Plain
      expect(config.adapter_loaded?(:'Doll::Adapter::Plain')).to be_truthy
    end
  end

  describe 'middleware' do
    it 'can add middleware' do
      middleware = Doll::NLP::Wit.new('example')

      config.use middleware
      expect(config.middlewares).to include(middleware)
    end
  end
end
