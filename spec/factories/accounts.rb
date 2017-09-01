require 'faker'

FactoryGirl.define do
  factory :account do
    iban Ibandit::IBAN.new(country_code: 'BE',
                           account_number: Faker::Number.number(16))
    balance 1000
  end
end
