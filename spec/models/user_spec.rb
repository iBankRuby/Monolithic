require 'spec_helper'
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'User' do
    it 'user exists' do
      a = described_class.new
      expect(a).to be_valid
    end
  end
end
