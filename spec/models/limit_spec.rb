require 'rails_helper'

RSpec.describe Limit, type: :model do
  it 'should have valid factory' do
    expect(build(:limit)).to be_valid
  end
end
