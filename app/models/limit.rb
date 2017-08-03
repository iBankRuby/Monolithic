class Limit < ApplicationRecord
  has_one :account, through: :roles
  has_one :role
end
