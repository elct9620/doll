require 'spec_helper'

RSpec.describe Doll do
  it 'has a version number' do
    expect(Doll::VERSION).not_to be nil
  end
end
