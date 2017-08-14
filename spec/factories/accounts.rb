require 'faker'

FactoryGirl.define do
  factory :account do
    iban Ibandit::IBAN.new(country_code: 'BE',
                           account_number: Forgery('credit_card').number)
    balance 1000
  end
end
