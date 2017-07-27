require 'faker'

FactoryGirl.define do
  factory :account do
    iban Faker::Number.number(16)
    balance 1000
  end
end
