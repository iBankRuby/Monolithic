require 'spec_helper'

describe "user valid?" do
  context "User" do
    it "user exists" do
      a = User.new
      expect(a).to be_valid
    end
  end
end


