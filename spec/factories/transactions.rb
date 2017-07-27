require 'faker'

FactoryGirl.define do
  factory :transaction do
    association :user
    association :account
    remote_account_id Faker::Number.number(16)
    summ 1000
  end
end
