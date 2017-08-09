class Role < ApplicationRecord
  belongs_to :user
  belongs_to :account

  validates :name, uniqueness: true
end
