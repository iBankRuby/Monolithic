FactoryGirl.define do
  factory :user, class: User do
    email 'me@example.com'
    password 'secret'
  end

  factory :another_user, class: User do
    email 'user@mail.com'
    password '123456'
  end
end
