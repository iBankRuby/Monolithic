class Limit < ApplicationRecord
  belongs_to :accounts, through: :roles
end
