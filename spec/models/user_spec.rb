require 'spec_helper'
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'User' do
    it 'user exists as described_class' do
      expect(build(:user)).to be_valid
    end
  end
end
