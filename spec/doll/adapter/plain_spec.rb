require 'spec_helper'

RSpec.describe Doll::Adapter::Plain do
  let(:adapter) { Doll::Adapter::Plain.new }

  describe '#verify_signature' do
    it 'always return true' do
      expect(adapter.verify_signature(nil)).to be_truthy
    end
  end

  describe '#process' do
    it 'can handle text message' do
      text = 'Type something...'
      expect(Doll::Message::Text).to receive(:new).with(text)
      adapter.process(text)
    end
  end
end
