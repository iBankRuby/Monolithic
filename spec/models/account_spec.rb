require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'should have valid factory' do
    expect(build(:account)).to be_valid
  end

  it 'should have valid factory' do
    expect(build(:account).my_method).to eq('works')
  end
end
