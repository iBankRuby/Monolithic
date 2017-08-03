class Role < ApplicationRecord
  validates :name, uniqueness: true
end
